import 'package:flutter/material.dart';
import 'package:taskaya/core/utilites/app_theme/colors.dart';
import 'package:taskaya/core/utilites/app_theme/text_style.dart';
import 'package:taskaya/core/utilites/functions/extension.dart';
class CustomDayContainerUsage extends StatelessWidget {
  const CustomDayContainerUsage({super.key,required this.width,required this.height,required this.percentage,required this.enable,required this.dayDuration});
  final double width;
  final double height;
  final double percentage;
  final bool enable;
  final Duration dayDuration;
  @override
  Widget build(BuildContext context) {
    return  Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        SizedBox(
            height: height*0.02,
            width: width*0.08,
            child: Text(dayDuration.getFormattedDuration(),style: CustomTextStyle.fontNormal12.copyWith(fontSize: 10),textAlign: TextAlign.center,)),
        SizedBox(height: height*0.01,),
        Container(
          height: percentage*height*0.23,
          width: width*0.08,
          decoration: BoxDecoration(
            color:enable?buttonColor:customBorderColor,
            borderRadius: BorderRadius.circular(5),
          ),
        ),
      ],
    );
  }
}