import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskaya/feature/calendar/data/model/calendar_model.dart';
import 'package:taskaya/feature/home/data/models/task_model.dart';

part 'calendar_event.dart';
part 'calendar_state.dart';

class CalendarBloc extends Bloc<CalendarEvent, CalendarState> {
  int currMonth=DateTime.now().month;
  int currYear=DateTime.now().year;
  int currDay=DateTime.now().day;
  List<TaskModel>taskList;
  ScrollController scrollController=ScrollController();
  DateTime currentDate=DateTime.now();
  bool isLoading=false;
  bool firstTime=true;
  List<CalendarModel>calendarDaysList=[];
  List<TaskModel>filteredList=[];
  CalendarBloc({required this.taskList}) : super(CalendarInitialState()) {
    on<CalendarEvent>((event, emit)async {
      switch(event){
        case InitialCalendarEvent():
          await fillCalendarDaysList(emit: emit);
          break;
        case ChangeCurrMonthEvent():
          await updateCalendarDueToMonthChange(emit: emit, increase: event.forward);
          break;
        case ChangeDayPickerEvent():
          await pickDay(index: event.index, emit: emit);
          break;
        case RefreshCalendarListEvent():
          await refreshCalendarList(emit: emit);
          break;
      }
    });
  }
  Future<void> updateCalendarDueToMonthChange({required Emitter<CalendarState>emit,required bool increase})async{
    currentDate=getCurrDateTime(increase: increase);
    fillCalendarDaysList(emit: emit);
    pickDay(index: 0, emit: emit);
    emit(UpdateCalendarMonthState());
  }

  Future<void>fillCalendarDaysList({required Emitter<CalendarState>emit})async{
    isLoading=true;
    calendarDaysList.clear();
    calendarDaysList=CalendarModel.getListOfDays(year: currYear, month: currMonth,);
    isLoading=false;
    scrollController.animateTo(0, duration: const Duration(seconds: 1), curve: Curves.easeInOut);
    emit(UpdateCalendarDaysState());
    if(firstTime){
      firstTime=false;
      pickDay(index: currDay-1, emit: emit);
    }
  }

  DateTime getCurrDateTime({required bool increase}){
    if(increase){
      if(currMonth==12){
        currMonth=1;
        currYear+=1;
      }
      else{
        currMonth++;
      }
    }
    else{
      if(currMonth==1){
        currMonth=12;
        currYear-=1;
      }
      else{
        currMonth--;
      }
    }

    return DateTime(currYear,currMonth,currDay);
  }
  Future<void> pickDay({required int index,required Emitter<CalendarState>emit})async{
    currDay=index+1;
    currentDate=DateTime(currYear,currMonth,currDay);
    emit(ChangePickedDayState());
    filterListAccordingToDay();
    emit(FilterListState());
  }

  void filterListAccordingToDay(){
    filteredList=List.from(filteredList=taskList.where((model){
      if(model.taskTime!=null){
        DateTime time=DateTime(model.taskTime!.year,model.taskTime!.month,model.taskTime!.day);
        if(time==currentDate){
          return true;
        }
        return false;
      }
      return false;
    }).toList());
  }

  Future<void>refreshCalendarList({required Emitter<CalendarState>emit})async{
    emit(RefreshListState());
  }
}
