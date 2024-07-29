import 'dart:math';
import 'package:flutter/material.dart';
import 'package:taskaya/core/utilites/app_theme/colors.dart';
import 'package:taskaya/core/utilites/app_theme/text_style.dart';
import 'package:taskaya/core/utilites/widgets/custom_alert_widget.dart';
import 'package:taskaya/core/utilites/widgets/custom_big_button.dart';

class LeaveAppOption extends StatelessWidget {
  const LeaveAppOption({super.key,this.yesFunction,this.noFunction});
  final void Function()?yesFunction;
  final void Function()?noFunction;
  @override
  Widget build(BuildContext context) {
    return CustomAlertWidget(
      title: Text("Are you Sure to Leave ?",style: CustomTextStyle.fontBold18,overflow: TextOverflow.ellipsis,),
      rightOption: CustomBigButton(label: "Yes",color: buttonColor,labelStyle: CustomTextStyle.fontBoldWhite16,),
      leftOption: TextButton(onPressed: noFunction,child: Text("No",style: CustomTextStyle.fontNormal16.copyWith(color: buttonColor),)),
    );
  }
}
extension RotateWidget on Widget {
  Widget rotate ({required double angle})=>Transform.rotate(
    angle: (angle*pi)/180,
    child: this
  );
}