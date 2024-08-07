import 'package:taskaya/core/utilites/functions/extension.dart';
import 'package:flutter/material.dart';
import 'package:taskaya/core/utilites/app_theme/text_style.dart';
import 'package:taskaya/feature/focus/data/model/focus_model.dart';
import 'package:taskaya/feature/focus/presentation/view/widgets/custom_circle_percentage.dart';

class CustomAppUsageItem extends StatelessWidget{
  const CustomAppUsageItem({super.key,required this.topAppModel,required this.width,required this.totalDayUsage});
  final TopApps topAppModel;
  final double width;
  final int totalDayUsage;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width*0.25,
      child: Column(
        children: [
          CircularPercentageAvatar(width: width,appIcon: topAppModel.appIcon??"",percentage: topAppModel.timeUsage!.inMilliseconds/totalDayUsage,),
          SizedBox(height: width*0.05,),
          Text("${topAppModel.appName}",style: CustomTextStyle.fontNormal14,),
          Text("${topAppModel.timeUsage?.getFormattedDuration(enable: true)}",style: CustomTextStyle.fontNormal14,),
        ],
      ),
    );
  }

}