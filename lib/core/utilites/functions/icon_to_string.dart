import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

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

return value !=null ?DateFormat('EEEE, MMMM d').format(value):null;
}