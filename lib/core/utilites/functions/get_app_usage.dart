import 'package:flutter/services.dart';

class UsageStatsService {
  static const MethodChannel _channel = MethodChannel('com.example.app/usage');

  Future<Map<String, dynamic>> getUsageStatsForLast7Days() async {
    try {
      final result = await _channel.invokeMethod('getUsageStatsForLast7Days');
      return Map<String, dynamic>.from(result);
    } on PlatformException catch (e) {
      print(e.toString());
     // debugPrint('Failed to get usage stats: ${e.message}');
      return {};
    }
  }
  Future<bool>isAccessGranted()async{
    final result=await _channel.invokeMethod("isUsageAccessGranted");
    return result;
  }
  Future<void>openSettingToGetAccess()async{
    await _channel.invokeMethod("openUsageAccessSettings");
  }
}