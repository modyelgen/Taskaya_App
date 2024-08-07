
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:taskaya/core/utilites/functions/get_app_usage.dart';
import 'package:taskaya/core/utilites/functions/get_curr_week_days.dart';
import 'package:taskaya/feature/focus/data/model/focus_model.dart';
import 'package:taskaya/feature/focus/data/repos/app_usage_repo.dart';
part 'focus_event.dart';
part 'focus_state.dart';

class FocusBloc extends Bloc<FocusEvent, FocusState> {
  List<AppUsage>appUsageList=[];
  bool isLoading=true;
  bool allowDenied=false;
  int largerDuration=0;
  List<String>weekDayList=[];
  List<Duration>steps=[];
  int currDayIndex=0;
  GetAppsUsageRepoImpl getAppUsageRepoImpl =GetAppsUsageRepoImpl();
  FocusBloc() : super(FocusInitialState()) {
    on<FocusEvent>((event, emit)async {
     switch(event){
       case InitialFocusEvent():
         await initLoadAppUsage(emit: emit);
         break;
         case ChangeDayUsageEvent():
           await changeCurrDay(currIndex: event.index, emit: emit);
           break;
       case DenyAllowAppUsageEvent():
         await onCancelGetAppsUsage(emit: emit);
         break;
     }
    });
  }
  Future<void>loadAppsUsage({required Emitter<FocusState> emit})async{
    var result=await getAppUsageRepoImpl.getAppsUsage();
    if(result.isLeft){
      if(result.getLeft!=null){
        appUsageList=List.from(result.getLeft!.toList());
        getTimeStepsAndLargeDuration();
        currDayIndex=appUsageList.length-1;
        weekDayList=getWeekDaysList(appUsageList);
      }
      emit(FocusSuccessAppsUsageState());
      isLoading=false;
    }
    else{
      emit(FocusFailureAppsUsageState(errMessage: result.getRight));
      isLoading=false;
    }

  }
  Future<void>initLoadAppUsage({required Emitter<FocusState> emit})async{
    emit(FocusLoadingAppsUsageState());
    var result=await getAppUsageRepoImpl.isAccessGranted();
    if(result.isLeft){
      if(result.getLeft==true){
        allowDenied=false;
        await loadAppsUsage(emit: emit);
      }
      else{
        emit(EnableShowAlertState());
      }
    }
    else{
      isLoading=false;
      allowDenied=true;
      emit(FocusFailureAppsUsageState(errMessage: result.getRight));
    }

  }
  Future<void>openSetting()async{
    await getAppUsageRepoImpl.openSetting().then((v)async{
      bool grantedAfter=false;
      while(!grantedAfter){
        await Future.delayed(const Duration(seconds: 1),()=>add(DenyAllowAppUsageEvent()));
        grantedAfter = await UsageStatsService().isAccessGranted();
      }
      if(grantedAfter){
        add(InitialFocusEvent());
      }
    });

  }
  Future<void> onCancelGetAppsUsage({required Emitter<FocusState>emit})async{
    isLoading=false;
    allowDenied=true;
    emit(AllowIsDeniedState());
  }

  Future<void>changeCurrDay({required int currIndex,required Emitter<FocusState>emit})async{
    currDayIndex=currIndex;
    emit(ChangeCurrDayInUsageListState());
  }

  void getTimeStepsAndLargeDuration(){
    int duration=appUsageList.first.totalUsage!.inMilliseconds;
    for(int i=1;i<appUsageList.length;i++){
      int tempDuration=appUsageList[i].totalUsage!.inMilliseconds;
      if(tempDuration>duration){
        duration=tempDuration;
      }
    }
    largerDuration=duration;
    int reminder=duration~/5;
    for(int i=0;i<5;i++){
      steps.add(Duration(milliseconds: duration));
      duration-=reminder;
    }

  }

}
