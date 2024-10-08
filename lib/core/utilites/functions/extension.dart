import 'package:taskaya/core/utilites/constants/parameters.dart';

extension SameDay on DateTime {
  bool checkDayEquality(){
    if(DateTime.now().day-day==0&&DateTime.now().month-month==0&&DateTime.now().year-year==0){
      return true;
    }
    return false;
  }
  bool isTomorrow() {
    if(day-DateTime.now().day==1&&DateTime.now().month-month==0&&DateTime.now().year-year==0){
      return true;
    }
    return false;
  }
  bool isYesterday() {
    if(DateTime.now().day-day==1&&DateTime.now().month-month==0&&DateTime.now().year-year==0){
      return true;
    }
    return false;
  }
}

extension GetCurrMonth on int{
  String getMonthName(){
    return monthNames[this-1];
  }
  String getDayName() {
    List<String> days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    return days[this - 1];
  }
}
extension HourMinute on Duration{
  String getFormattedDuration({bool enable=false})
  {
    int totalMinutes = inMinutes;
    int hours = totalMinutes ~/ 60;
    int minutes = totalMinutes % 60;
    String formattedHours = hours.toString().padLeft(2, '0');
    String formattedMinutes = minutes.toString().padLeft(2, '0');
    return "$formattedHours${enable?" hr":""}:$formattedMinutes${enable? " M":""}";
  }
}
