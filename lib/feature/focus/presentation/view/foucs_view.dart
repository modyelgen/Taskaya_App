import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:taskaya/core/utilites/app_theme/colors.dart';
import 'package:taskaya/core/utilites/app_theme/text_style.dart';
import 'package:taskaya/core/utilites/dimensions/responsive_layout.dart';
import 'package:taskaya/core/utilites/functions/theme_function.dart';
import 'package:taskaya/core/utilites/widgets/custom_big_button.dart';

class FocusView extends StatelessWidget {
  const FocusView({super.key});

  @override
  Widget build(BuildContext context) {
    final double height=BasicDimension.screenHeight(context);
    final double width=BasicDimension.screenWidth(context);
    return SafeArea(
      child: Scaffold(
        body: ListView(
          padding: EdgeInsetsDirectional.symmetric(horizontal: width*0.05,vertical: height*0.015).copyWith(bottom: height*0.05),
          children: [
            Center(child: Text("Focus View",style: CustomTextStyle.fontBold21,)),
            SizedBox(height: height*0.02,),
            CircularPercentageAvatar(width: width),
            SizedBox(height: height*0.02,),
            SizedBox(
                width: width*0.75,
                child: Text("While your focus mode is on, all of your notifications will be off",style: CustomTextStyle.fontNormal14,maxLines: 3,textAlign: TextAlign.center,)),
            SizedBox(height: height*0.02,),
            Center(
              child: CustomBigButton(
                altWidth: width*0.4,
                borderRadius: 4,
                label: "Start Focusing",
                labelStyle: CustomTextStyle.fontBoldWhite16,
                color: buttonColor,
              ),
            ),
            SizedBox(height: height*0.033,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Overview",style: CustomTextStyle.fontBold18,),
                CustomBigButton(
                  altWidth: width*0.33,
                  borderRadius: 4,
                  altWidget: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("This Week",style: CustomTextStyle.fontNormal14,),
                        const Icon(CupertinoIcons.arrow_turn_right_down)
                      ],
                    ),
                  ),
                  color: bottomNavBarColor,
                ),
              ],
            ),
            SizedBox(height: height*0.015,),
            CustomChart(height: height, width: width),
            SizedBox(height: height*0.033,),
            SizedBox(
              height: height*0.3,
              width: width,
              child: ListView.separated(itemBuilder: (context,index){
                return ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: ColoredBox(
                    color: bottomNavBarColor,
                    child: const ListTile(
                      leading: Icon(Icons.facebook),
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("FaceBook"),
                          Text("You spent 4h on Instagram today"),
                        ],
                      ),
                      trailing: Icon(Icons.warning),
                    ),
                  ),
                );
              }, separatorBuilder: (context,index){
                return SizedBox(
                  height: height*0.015,
                );
              }, itemCount: 5),
            ),
         ],
        ),
      ),
    );
  }
}
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

class CustomChart extends StatelessWidget {
  const CustomChart({super.key,required this.height,required this.width});
  final double width;
  final double height;
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.center,
      children: [
        Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                SizedBox(
                  height: height*0.28,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ...List.generate(5, (index)=>Text("${5-index}")),
                    ],
                  ),
                ),
                SizedBox(width: width*0.025,),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    SizedBox(
                      height: height*0.3,
                        child: const VerticalDivider(thickness: 2,width: 0,)),
                    SizedBox(
                        width: width*0.8,
                        child: const Divider(thickness: 2,height: 0,)),
                  ],
                ),
              ],
            ),
            SizedBox(
              width: width*0.75,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ...List.generate(weekDay.length, (index)=>SizedBox(
                      width: width*0.1,
                      child: Text(weekDay[index],textAlign: TextAlign.center,))),
                ],
              ),
            ),
          ],
        ),
        SizedBox(
          width: width*0.75,
          height: height*0.28,
          child:Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ...List.generate(7, (index)=>CustomDayContainerUsage(width: width))
            ],
          )
        ),
      ],
    );
  }
}
List<String>weekDay=["FRI","SAT","SUN","MON","TUE","WED","THU"];

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

