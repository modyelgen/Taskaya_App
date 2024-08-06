import 'package:flutter/material.dart';
import 'package:taskaya/core/utilites/app_theme/colors.dart';

class CustomDayContainerUsage extends StatelessWidget {
  const CustomDayContainerUsage({super.key,required this.width});
  final double width;
  @override
  Widget build(BuildContext context) {
    return  Container(
      height: width*0.5,
      width: width*0.08,
      decoration: BoxDecoration(
        color: customBorderColor,
        borderRadius: BorderRadius.circular(5),
      ),
    );
  }
}