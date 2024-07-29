import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:taskaya/core/utilites/app_theme/colors.dart';
import 'package:taskaya/core/utilites/app_theme/text_style.dart';
import 'package:taskaya/core/utilites/widgets/custom_big_button.dart';

class OnePriorityInTask extends StatelessWidget {
  const OnePriorityInTask({
    super.key,
    required this.width,
    required this.priority,
    this.enableWidth=false,
  });

  final double width;
  final int priority;
  final bool enableWidth;
  @override
  Widget build(BuildContext context) {
    return CustomBigButton(
      altWidth: enableWidth?width*0.3:null,
      borderRadius: 4,
      color: bottomNavBarColor,
      boxBorder: Border.all(color: buttonColor,width: 2,),
      altWidget:  Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Icon(CupertinoIcons.flag,color: Colors.white,),
          SizedBox(width: width*0.025,),
          Text("${priority+1}",style: CustomTextStyle.fontBoldWhite16.copyWith(fontSize: 12),),
        ],
      ),);
  }
}