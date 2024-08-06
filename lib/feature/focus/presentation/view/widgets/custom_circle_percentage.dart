import 'package:flutter/material.dart';
import 'package:taskaya/core/utilites/app_theme/colors.dart';
import 'package:taskaya/core/utilites/app_theme/text_style.dart';
import 'package:taskaya/core/utilites/functions/theme_function.dart';

class CircularPercentageAvatar extends StatelessWidget {
  const CircularPercentageAvatar({super.key,required this.width});
  final double width;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.center,
      children: [
        SizedBox(
          width: width*0.45,
          height: width*0.45,
          child: CircularProgressIndicator(
            strokeWidth: 20,
            value: 0.5,
            strokeCap: StrokeCap.round,
            backgroundColor: bottomNavBarColor,
            color: buttonColor,
          ),
        ),
        CircleAvatar(
          radius:width*0.2,
          backgroundColor: GetColor(context: context).getInverseColor(),
          child: Text("00:30",style: CustomTextStyle.fontBold32.copyWith(color: GetColor(context: context).getNormalColor(),),),
        ),
      ],
    );
  }
}