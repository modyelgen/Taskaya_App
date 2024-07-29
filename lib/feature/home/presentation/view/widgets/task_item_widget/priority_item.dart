import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:taskaya/core/utilites/app_theme/colors.dart';
import 'package:taskaya/core/utilites/app_theme/text_style.dart';

class PriorityItem extends StatelessWidget {
  const PriorityItem({super.key,required this.index,required this.width,required this.height,required this.curr});
  final int index;
  final bool curr;
  final double width;
  final double height;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsetsDirectional.symmetric(horizontal: width*0.05,vertical: height*0.015),
      decoration: BoxDecoration(
        color:curr?buttonColor:const Color(0xff272727),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Column(
        children: [
          const Icon(CupertinoIcons.flag,color: Colors.white,size: 30,),
          Text("${index+1}",style: CustomTextStyle.fontNormal14.copyWith(color: Colors.white),)
        ],
      ),
    );
  }
}