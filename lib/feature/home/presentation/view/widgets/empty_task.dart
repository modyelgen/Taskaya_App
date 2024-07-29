import 'package:flutter/material.dart';
import 'package:taskaya/core/utilites/app_theme/text_style.dart';
import 'package:taskaya/core/utilites/custom_localization/custom_app_localization.dart';

class EmptyTasks extends StatelessWidget {
  const EmptyTasks({
    super.key,
    required this.width,
    required this.height,
  });

  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset("assets/home/empty_tasks.png",fit: BoxFit.fitHeight,width: width,height: height*0.25,),
        SizedBox(height: height*0.015,),
        Column(
          children: [
            Text("emptyTaskTitle".tr(context),style: CustomTextStyle.fontBold21,),
            SizedBox(height: height*0.009,),
            Text("emptyTaskSec".tr(context),style: CustomTextStyle.fontBold16,),
          ],
        ),
      ],
    );
  }
}