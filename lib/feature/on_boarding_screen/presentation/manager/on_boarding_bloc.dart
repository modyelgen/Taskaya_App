
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:taskaya/core/utilites/cache_helper/shared_pref.dart';

part 'on_boarding_event.dart';
part 'on_boarding_state.dart';

class OnBoardingBloc extends Bloc<OnBoardingEvent, OnBoardingState> {
  int currIndex=0;
  PageController pageController=PageController(initialPage: 0);

  OnBoardingBloc() : super(OnBoardingInitial()) {
    on<OnBoardingEvent>((event, emit) async{
      if(event is MoveForwardEvent){
        if(currIndex<2){
          currIndex++;
          pageController.jumpToPage(currIndex);
          await SetAppState.setCurrIndex(index: currIndex);
          emit(OnBoardingChangePage());
        }
        else if (currIndex==2){
          emit(OnBoardingFinishedState());
        }
      }
      else if(event is MoveBackwardEvent){
        if(currIndex>0){
          currIndex--;
          pageController.jumpToPage(currIndex);
          await SetAppState.setCurrIndex(index: currIndex);
          emit(OnBoardingChangePage());
        }
      }
      else if(event is TogglePageEvent){
        currIndex=event.index;
        await SetAppState.setCurrIndex(index: currIndex);
        emit(OnBoardingChangePage());
      }
    });
  }

}
