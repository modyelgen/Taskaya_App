import 'package:flutter/material.dart';
import 'package:taskaya/core/utilites/app_theme/colors.dart';
import 'package:taskaya/core/utilites/app_theme/text_style.dart';
import 'package:taskaya/core/utilites/widgets/custom_text_form_field.dart';

import 'remind_complete_tasks.dart';

class CustomChangeNameBottomSheet extends StatelessWidget {
  const CustomChangeNameBottomSheet({super.key,required this.width,required this.height,required this.controller,required this.onEdit});
  final double width;
  final double height;
  final TextEditingController controller;
  final void Function() onEdit;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:EdgeInsets.all(width*0.02),
      width: width*0.9,
      height: height*0.26,
      decoration: BoxDecoration(
        color: bottomNavBarColor,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Column(
        children: [
          SizedBox(
              height: height*0.03,
              child: Text("Change Account Name",style: CustomTextStyle.fontBoldWhite16,)),
          SizedBox(height: height*0.01,),
          SizedBox(
            width: width*0.8,
            height: height*0.015,
            child: const Divider(
              color: Color(0xff979797),
            ),
          ),
          SizedBox(height: height*0.01,),
          SizedBox(
            width: width*0.75,
            child: CustomTextFormField(
              border: 4,
              style: CustomTextStyle.fontNormal14.copyWith(color: Colors.white),
              borderColor: customBorderColor,
              controller:controller,
            ),
          ),
          SizedBox(height: height*0.015,),
          SizedBox(
            height: height*0.07,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(onPressed: (){
                  Navigator.pop(context);
                },child:Text("Cancel",style: CustomTextStyle.fontNormal14.copyWith(color: purpleColor),),),
                GestureDetector(
                    onTap: onEdit,
                    child: RemainOrCompleteTasks(width: width*0.8, height: height*0.8, text: "Edit",backGroundColor: purpleColor,))
              ],
            ),
          )
        ],
      ),
    );
  }
}