import 'dart:developer';

import 'package:taskaya/core/utilites/functions/either_class.dart';
import 'package:taskaya/core/utilites/functions/get_app_usage.dart';
import 'package:taskaya/feature/focus/data/model/focus_model.dart';

abstract class GetAppsUsageRepo{
  Future<Either<List<AppUsage>,String>>getAppsUsage();
  Future<Either<bool,String>>isAccessGranted();
  Future<void>openSetting();

}
class GetAppsUsageRepoImpl extends GetAppsUsageRepo{
  UsageStatsService usageStatsService=UsageStatsService();
  @override
  Future<Either<List<AppUsage>, String>> getAppsUsage() async{
    List<AppUsage>appUsageList=[];
    try{
      var result=await  usageStatsService.getUsageStatsForLast7Days();
      if(result["dailyUsageList"]!=null){
        for(var item in result["dailyUsageList"]){
          appUsageList.add(AppUsage.usageOfApps(item));
        }
      }
      return Either.left(appUsageList);
    }
    catch(e){
      log(e.toString());
      return Either.right(e.toString());
    }
  }

  @override
  Future<Either<bool, String>> isAccessGranted() async{
    bool access=false;
    try{
     await usageStatsService.isAccessGranted().then((value){
       access=value;
     });
     return Either.left(access);
    }
    catch (e){
      log(e.toString());
      return Either.right(e.toString());
    }
  }

  @override
  Future<void> openSetting() async{
    try{
      await usageStatsService.openSettingToGetAccess();
    }
    catch(e){
      log(e.toString());
    }

  }


}