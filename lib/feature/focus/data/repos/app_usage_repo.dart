import 'package:taskaya/core/utilites/functions/either_class.dart';
import 'package:taskaya/core/utilites/functions/get_app_usage.dart';
import 'package:taskaya/feature/focus/data/model/focus_model.dart';

abstract class GetAppsUsageRepo{
  Future<Either<List<AppUsage>,String>>getAppsUsage();
}
class GetAppsUsageRepoImpl extends GetAppsUsageRepo{
  @override
  Future<Either<List<AppUsage>, String>> getAppsUsage() async{
    List<AppUsage>appUsageList=[];
    UsageStatsService usageStatsService=UsageStatsService();
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
      return Either.right(e.toString());
    }
  }

}