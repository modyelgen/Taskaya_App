import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';

IconData stringToIconData({required String iconString}) {
  List<String> parts = iconString.split(',');
  String fontFamily = parts[0];
  int codePoint = int.parse(parts[1]);
  return IconData(codePoint, fontFamily: fontFamily);
}
String iconDataToString({required IconData iconData})
{
  return '${iconData.fontFamily},${iconData.codePoint}';
}