import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/cupertino.dart';

part 'on_boarding_event.dart';
part 'on_boarding_state.dart';

class OnBoardingBloc extends Bloc<OnBoardingEvent, OnBoardingState> {
  int currIndex=0;
  PageController pageController=PageController(initialPage: 0);
  OnBoardingBloc() : super(OnBoardingInitial()) {
    on<OnBoardingEvent>((event, emit) {
      if(event is MoveForwardEvent){
        if(currIndex<2){
          currIndex++;
          pageController.jumpToPage(currIndex);
        emit(OnBoardingChangePage());
        }
      }
      else if(event is MoveBackwardEvent){
        if(currIndex>0){
          currIndex--;
          pageController.jumpToPage(currIndex);
          emit(OnBoardingChangePage());
        }
      }
      else if(event is TogglePageEvent){
        currIndex=event.index;
        emit(OnBoardingChangePage());
      }
    });
  }
}
