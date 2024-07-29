import 'package:flutter/material.dart';
import 'package:taskaya/core/utilites/app_theme/colors.dart';
import 'package:taskaya/core/utilites/app_theme/text_style.dart';
import 'package:taskaya/core/utilites/functions/icon_to_string.dart';
import 'package:taskaya/feature/home/data/models/task_model.dart';

class OneTextInTaskItem extends StatelessWidget {
  const OneTextInTaskItem({super.key,required this.model});
  final TaskTimeModel model;
  @override
  Widget build(BuildContext context) {
    return Text("${getFormattedDay(model.dayDate)??""} At ${model.dayHourMinute?.hour??""}:${model.dayHourMinute?.minute??""}",style: CustomTextStyle.fontNormal12.copyWith(color: customBorderColor),maxLines: 2,overflow: TextOverflow.ellipsis,);
  }
}