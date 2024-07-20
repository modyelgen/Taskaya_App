import 'package:flutter/material.dart';
import 'package:taskaya/core/utilites/app_theme/text_style.dart';
import 'package:taskaya/core/utilites/custom_localization/custom_app_localization.dart';
import 'package:taskaya/feature/on_boarding_screen/data/model.dart';
import 'package:taskaya/core/utilites/app_theme/colors.dart';
class CustomOnBoardingPage extends StatelessWidget {
  const CustomOnBoardingPage({super.key,required this.toggleMode,required this.toggleLang,required this.height,required this.width,required this.model,required this.currIndex,required this.moveBackward,required this.moveForward});
  final double width;
  final double height;
  final OnBoardingModel model;
  final int currIndex;
  final void Function() moveForward;
  final void Function() moveBackward;
  final void Function() toggleMode;
  final void Function() toggleLang;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: width*0.05,vertical: height*0.02),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: toggleLang,
                  child: Container(
                    width: width*0.1,
                    height: height*0.05,
                    decoration: BoxDecoration(
                      color: purpleColor,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(child: Text("curr_Lang".tr(context),style: CustomTextStyle.fontBoldWhite16)),
                  ),
                ),
                CircleAvatar(
                    child: IconButton(onPressed: toggleMode, icon:Icon(Icons.dark_mode,color: Theme.of(context).colorScheme.onInverseSurface,)))
              ],
            ),
            SizedBox(height: height*0.05),
            Image.asset(model.assetPath,width: width*0.6,height: height*0.33,fit: BoxFit.fill,),
            SizedBox(height: height*0.05),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ...List.generate(3, (index) =>Padding(
                  padding: EdgeInsets.only(right: width*0.015),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: index==currIndex?purpleColor:Colors.grey,
                    ),
                    width: width*0.075,
                    height: height*0.008,
                  ),
                )),
              ],
            ),
            SizedBox(height: height*0.05,),
            SizedBox(
              width: width,
              height: height*0.075,
              child: Text(model.mainTitle.tr(context),style: CustomTextStyle.fontBold32,textAlign: TextAlign.center,),
            ),
            SizedBox(height: height*0.025,),
            SizedBox(
              width: width*0.75,
              height: height*0.1,
              child: Text(model.secondaryTitle.tr(context),style:CustomTextStyle.fontNormal16,maxLines: 3,textAlign: TextAlign.center,),
            ),
            SizedBox(height: height*0.1,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(onPressed: moveBackward,child:Text("back_Button".tr(context),style: CustomTextStyle.fontBold16.copyWith(color: Colors.grey))),
                GestureDetector(
                  onTap: moveForward,
                  child: Container(
                      width: width*0.2,
                      height: height*0.05,
                      padding: const EdgeInsets.all(7),
                      decoration: BoxDecoration(
                        color: purpleColor,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child:Center(child:  Text("next_Button".tr(context),style: CustomTextStyle.fontBoldWhite16))),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}