import 'package:taskaya/core/utilites/functions/extension.dart';

class CalendarModel {
  int dayNum;
  String dayName;
  CalendarModel({required this.dayNum,required this.dayName});

  static List<CalendarModel> getListOfDays({required int year,required int month}){
    List<CalendarModel> calendarList=[];
    DateTime lastDayOfMonth = DateTime(year, month + 1, 0);
    for (int day = 1; day <= lastDayOfMonth.day; day++) {
      DateTime date = DateTime(year, month, day);
      CalendarModel model = CalendarModel(dayNum: day, dayName: date.weekday.getDayName());
      calendarList.add(model);
    }
    return calendarList;
  }
}