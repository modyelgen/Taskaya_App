import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:taskaya/core/utilites/functions/extension.dart';

IconData stringToIconData({required String iconString}) {
  List<String> parts = iconString.split(',');
  String fontFamily = parts[0];
  int codePoint = int.parse(parts[1]);
  return IconData(codePoint, fontFamily: fontFamily);
}
String iconDataToString({required IconData iconData})
{
  return '${iconData.fontFamily},${iconData.codePoint.toString()}';
}
String? getFormattedDay(DateTime?value){
  if(value!=null){
    if(value.checkDayEquality()){
      return "Today";
    }
    else if(value.isTomorrow()){
      return "Tomorrow";
    }
    else if(value.isYesterday()){
      return "yesterday";
    }
    else{
      return DateFormat('EEEE, MMMM d').format(value);
    }
  }
  return null;
}

