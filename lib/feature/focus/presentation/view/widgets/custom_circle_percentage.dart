import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:taskaya/core/utilites/app_theme/colors.dart';
import 'package:taskaya/core/utilites/functions/theme_function.dart';

class CircularPercentageAvatar extends StatelessWidget {
  const CircularPercentageAvatar({super.key,required this.width,required this.appIcon,required this.percentage});
  final double width;
  final String appIcon;
  final double percentage;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.center,
      children: [
        SizedBox(
          width: width*0.2,
          height: width*0.2,
          child: CircularProgressIndicator(
            strokeWidth: 5,
            value: percentage,
            strokeCap: StrokeCap.round,
            backgroundColor: const Color(0xffBDBDBD),
            color: buttonColor,
          ),
        ),
        CircleAvatar(
          radius:width*0.06,
          backgroundColor: GetColor(context: context).getInverseColor(),
          child: appIcon==""?const Icon(Icons.error):Center(child: Image.memory(base64Decode(appIcon),errorBuilder: (context,_,s)=>const Icon(Icons.error),))
        ),
      ],
    );
  }
}