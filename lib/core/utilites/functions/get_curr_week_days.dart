import 'package:intl/intl.dart';
import 'package:taskaya/core/utilites/constants/parameters.dart';
import 'package:taskaya/feature/focus/data/model/focus_model.dart';

List<String>getWeekDaysList(List<AppUsage>list){
  List<String>days=[];
  for(var item in list){
    DateFormat inputFormat = DateFormat('dd/MM/yyyy');
    DateTime date = inputFormat.parse(item.dayDate!);
    days.add(weekDay[date.weekday-1]);
  }
  return days;
}
int roundDurationToNearestHour(Duration duration) {
  // Convert the duration to total hours
  double totalHours = duration.inMilliseconds / (1000 * 60 * 60);

  // Round to the nearest whole number
  int roundedHours = totalHours.ceil();

  return roundedHours;
}
