import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:taskaya/core/utilites/app_theme/colors.dart';
import 'package:taskaya/core/utilites/app_theme/text_style.dart';
import 'package:taskaya/core/utilites/custom_localization/custom_app_localization.dart';
import 'package:taskaya/core/utilites/dimensions/responsive_layout.dart';
import 'package:taskaya/core/utilites/widgets/custom_big_button.dart';
import 'package:taskaya/core/utilites/widgets/custom_text_form_field.dart';
class StartScreenView extends StatelessWidget {
  const StartScreenView({super.key});
  @override
  Widget build(BuildContext context) {
    final double width=BasicDimension.screenWidth(context);
    final double height=BasicDimension.screenHeight(context);
    return Scaffold(
      body: SafeArea(
          child:SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconButton(onPressed: (){
                  Navigator.pop(context);
                }, icon: const Icon(Icons.arrow_back_ios_new,),),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: width*0.05).copyWith(bottom: height*0.05),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: height*0.05,),
                      SizedBox(
                          width: width,
                          height: height*0.075,
                          child: Text("welcome_Message".tr(context),style: CustomTextStyle.fontBold32,textAlign: TextAlign.center,)),
                      SizedBox(height: height*0.05,),
                      CircleAvatar(
                        radius: width*0.2,
                        child: Icon(CupertinoIcons.person_badge_plus_fill,size: width*0.15,),
                      ),
                      SizedBox(height: height*0.05,),
                      CustomTextFormField(label: "enter_Name".tr(context),filled: true,borderColor: purpleColor,),
                      SizedBox(height: height*0.05,),
                      CustomBigButton(color: purpleColor,altWidth: width,label: "join".tr(context),labelStyle: CustomTextStyle.fontBoldWhite16,borderRadius: 4,),
                      SizedBox(height: height*0.02,),
                      CustomBigButton(altWidth: width,label: "skip".tr(context),labelStyle: CustomTextStyle.fontBold16,boxBorder: Border.all(color: purpleColor,width: 2),borderRadius: 4,),
                    ],
                  ),
                ),
              ],
            ),
          ),
      ),
    );
  }
}

