import 'package:flutter/material.dart';
import 'package:taskaya/core/utilites/app_theme/colors.dart';
import 'package:taskaya/core/utilites/app_theme/text_style.dart';
import 'package:taskaya/core/utilites/functions/icon_to_string.dart';

class OneTextInTaskItem extends StatelessWidget {
  const OneTextInTaskItem({super.key,required this.dateTime});
  final DateTime dateTime;
  @override
  Widget build(BuildContext context) {
    return Text("${getFormattedDay(dateTime)??""} At ${dateTime.hour}:${dateTime.minute}",style: CustomTextStyle.fontNormal12.copyWith(color:dateTime.isBefore(DateTime.now())?deleteColor:customBorderColor,),maxLines: 2,overflow: TextOverflow.ellipsis,);
  }
}