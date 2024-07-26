import 'package:flutter/material.dart';
import 'package:taskaya/core/utilites/app_theme/colors.dart';
import 'package:taskaya/core/utilites/app_theme/text_style.dart';

class RemainOrCompleteTasks extends StatelessWidget {
  const RemainOrCompleteTasks({super.key,required this.width,required this.height,required this.text,this.backGroundColor});
  final double width;
  final double height;
  final String text;
  final Color? backGroundColor;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      width:width*0.425,
      height: height*0.08,
      decoration: BoxDecoration(
        color:backGroundColor?? bottomNavBarColor,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Center(child: Text(text,style: CustomTextStyle.fontBoldWhite16,)),
    );
  }
}