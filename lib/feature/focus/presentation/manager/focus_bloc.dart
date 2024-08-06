
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:taskaya/feature/focus/data/model/focus_model.dart';
import 'package:taskaya/feature/focus/data/repos/app_usage_repo.dart';
part 'focus_event.dart';
part 'focus_state.dart';

class FocusBloc extends Bloc<FocusEvent, FocusState> {
  List<AppUsage>appUsageList=[];
  bool isLoading=false;
  GetAppsUsageRepoImpl getAppUsageRepoImpl =GetAppsUsageRepoImpl();
  FocusBloc() : super(FocusInitialState()) {
    on<FocusEvent>((event, emit)async {
     switch(event){
       case InitialFocusEvent():
         await loadAppsUsage(emit: emit);
         break;

         case ChangeDayUsageEvent():
           break;
         // TODO: Handle this case.
     }
    });
  }
  Future<void>loadAppsUsage({required Emitter<FocusState> emit})async{
    isLoading=true;
    emit(FocusLoadingAppsUsageState());
    var result=await getAppUsageRepoImpl.getAppsUsage();
    if(result.isLeft){
      if(result.getLeft!=null){
        appUsageList=List.from(result.getLeft!.toList());
      }
      emit(FocusSuccessAppsUsageState());
      isLoading=false;
    }
    else{
      print(result.getRight);
      emit(FocusFailureAppsUsageState(errMessage: result.getRight));
      isLoading=false;
    }

  }
}
