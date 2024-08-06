package com.example.taskaya

import android.annotation.TargetApi
import android.app.AppOpsManager
import android.app.usage.UsageStatsManager
import android.content.Context
import android.content.Intent
import android.content.pm.ApplicationInfo
import android.content.pm.PackageManager
import android.graphics.Bitmap
import android.graphics.drawable.Drawable
import android.os.Binder
import android.os.Build
import android.provider.Settings
import android.util.Base64
import androidx.annotation.NonNull
import androidx.core.graphics.drawable.toBitmap
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import java.io.ByteArrayOutputStream
import java.util.Calendar
import java.text.SimpleDateFormat
import java.util.*

class MainActivity : FlutterActivity() {
    private val CHANNEL = "com.example.app/usage"

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler {
                call: MethodCall, result: MethodChannel.Result ->
            when (call.method) {
                "getUsageStatsForLast7Days" -> {
                    val endDate: Long = System.currentTimeMillis()
                    val startDate: Long = endDate - 7 * 24 * 60 * 60 * 1000 // 7 days ago

                    val usageStatsFor7Days = getUsageStatsForLast7Days(startDate, endDate)
                    result.success(usageStatsFor7Days)
                }
                "getDailyUsage" -> {
                    val date: Long? = call.argument("date")

                    if (date != null) {
                        val dailyUsage = getDailyUsage(date)
                        result.success(dailyUsage)
                    } else {
                        result.error("INVALID_ARGUMENT", "Invalid date", null)
                    }
                }
                "openUsageAccessSettings" -> {
                    openUsageAccessSettings()
                    result.success(null)
                }
                "isUsageAccessGranted" -> {
                    val isGranted = isUsageAccessGranted()
                    result.success(isGranted)
                }
                else -> result.notImplemented()
            }
        }
    }

    @TargetApi(Build.VERSION_CODES.LOLLIPOP)
    private fun getUsageStatsForLast7Days(startDate: Long, endDate: Long): Map<String, Any> {
        val usageStatsManager = getSystemService(Context.USAGE_STATS_SERVICE) as UsageStatsManager
        val dailyUsageMap = mutableMapOf<Long, List<Map<String, Any>>>()

        val calendar = Calendar.getInstance()

        for (i in 0 until 7) {
            calendar.timeInMillis = startDate + i * 24 * 60 * 60 * 1000
            val startOfDay = calendar.timeInMillis
            calendar.add(Calendar.DAY_OF_MONTH, 1)
            val endOfDay = calendar.timeInMillis - 1

            val usageStatsList = usageStatsManager.queryUsageStats(
                UsageStatsManager.INTERVAL_DAILY, startOfDay, endOfDay
            )

            val dailyUsage = mutableMapOf<String, Long>()
            for (usageStats in usageStatsList) {
                val packageName = usageStats.packageName
                val totalTimeInForeground = usageStats.totalTimeInForeground
                dailyUsage[packageName] = (dailyUsage[packageName] ?: 0) + totalTimeInForeground
            }

            // Sort the apps by usage time and get the top 7
            val topApps = dailyUsage.entries.sortedByDescending { it.value }
                .take(7)
                .map {
                    val packageName = it.key
                    val totalTimeInForeground = it.value
                    val appName = getAppName(packageName)
                    val appIcon = getAppIconBase64(packageName)

                    mapOf(
                        "packageName" to packageName,
                        "appName" to appName,
                        "totalTimeInForeground" to totalTimeInForeground,
                        "appIcon" to (appIcon ?: "")
                    )
                }

            val formattedDate = Calendar.getInstance().apply { timeInMillis = startOfDay }.time.toString()
            dailyUsageMap[startOfDay] = topApps
        }

        val result = mutableMapOf<String, Any>()
        val dailyUsageList = mutableListOf<Map<String, Any>>()

        for ((date, topApps) in dailyUsageMap) {
            val dateFormat = SimpleDateFormat("dd/MM/yyyy", Locale.getDefault())
            val formattedDate = dateFormat.format(Date(date))

            dailyUsageList.add(
                mapOf(
                    "date" to formattedDate,
                    "topApps" to topApps
                )
            )
        }

        result["dailyUsageList"] = dailyUsageList
        return result
    }

    @TargetApi(Build.VERSION_CODES.LOLLIPOP)
    private fun getDailyUsage(date: Long): Map<String, Any> {
        val usageStatsManager = getSystemService(Context.USAGE_STATS_SERVICE) as UsageStatsManager
        val startOfDay = date
        val endOfDay = startOfDay + 24 * 60 * 60 * 1000 - 1 // End of the day

        val usageStatsList = usageStatsManager.queryUsageStats(
            UsageStatsManager.INTERVAL_DAILY, startOfDay, endOfDay
        )

        val dailyUsageMap = mutableMapOf<String, Long>()
        val packageManager = packageManager

        for (usageStats in usageStatsList) {
            val packageName = usageStats.packageName
            val totalTimeInForeground = usageStats.totalTimeInForeground
            dailyUsageMap[packageName] = (dailyUsageMap[packageName] ?: 0) + totalTimeInForeground
        }

        val dailyUsageList = mutableListOf<Map<String, Any>>()
        var totalUsageTime: Long = 0

        for ((packageName, totalTimeInForeground) in dailyUsageMap) {
            totalUsageTime += totalTimeInForeground
            val appName = getAppName(packageName)
            val appIcon = getAppIconBase64(packageName)

            val appUsage: Map<String, Any> = mapOf(
                "packageName" to packageName,
                "appName" to appName,
                "totalTimeInForeground" to totalTimeInForeground,
                "appIcon" to (appIcon ?: "")
            )
            dailyUsageList.add(appUsage)
        }

        return mapOf(
            "totalUsageTime" to totalUsageTime,
            "dailyUsageList" to dailyUsageList
        )
    }

    private fun getAppName(packageName: String): String {
        return try {
            val applicationInfo: ApplicationInfo = packageManager.getApplicationInfo(packageName, 0)
            packageManager.getApplicationLabel(applicationInfo).toString()
        } catch (e: PackageManager.NameNotFoundException) {
            packageName
        }
    }

    @TargetApi(Build.VERSION_CODES.FROYO)
    private fun getAppIconBase64(packageName: String): String? {
        return try {
            val drawable: Drawable = packageManager.getApplicationIcon(packageName)
            val bitmap = drawable.toBitmap()
            val byteArrayOutputStream = ByteArrayOutputStream()
            bitmap.compress(Bitmap.CompressFormat.PNG, 100, byteArrayOutputStream)
            val byteArray = byteArrayOutputStream.toByteArray()
            Base64.encodeToString(byteArray, Base64.NO_WRAP)  // Use NO_WRAP to avoid extra characters
        } catch (e: PackageManager.NameNotFoundException) {
            null
        }
    }

    @TargetApi(Build.VERSION_CODES.LOLLIPOP)
    private fun openUsageAccessSettings() {
        val intent = Intent(Settings.ACTION_USAGE_ACCESS_SETTINGS)
        startActivity(intent)
    }

    @TargetApi(Build.VERSION_CODES.KITKAT)
    private fun isUsageAccessGranted(): Boolean {
        val appOpsManager = getSystemService(Context.APP_OPS_SERVICE) as AppOpsManager
        val mode = if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.Q) {
            appOpsManager.unsafeCheckOpNoThrow(
                AppOpsManager.OPSTR_GET_USAGE_STATS,
                Binder.getCallingUid(),
                packageName
            )
        } else {
            appOpsManager.checkOpNoThrow(
                AppOpsManager.OPSTR_GET_USAGE_STATS,
                Binder.getCallingUid(),
                packageName
            )
        }
        return mode == AppOpsManager.MODE_ALLOWED
    }
}
