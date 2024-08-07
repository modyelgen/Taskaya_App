import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:taskaya/core/utilites/app_theme/colors.dart';
import 'package:taskaya/core/utilites/app_theme/text_style.dart';
import 'package:taskaya/core/utilites/widgets/custom_big_button.dart';
import 'package:taskaya/feature/focus/data/model/focus_model.dart';
import 'package:taskaya/feature/focus/presentation/manager/focus_bloc.dart';
import 'package:taskaya/feature/focus/presentation/view/widgets/app_usage_item.dart';
import 'package:taskaya/feature/focus/presentation/view/widgets/custom_chart.dart';

class FocusBody extends StatelessWidget {
  const FocusBody({
    super.key,
    required this.width,
    required this.height,
    required this.bloc,
  });

  final double width;
  final double height;
  final FocusBloc bloc;

  @override
  Widget build(BuildContext context) {
    List<TopApps>list=bloc.appUsageList[bloc.currDayIndex].topApps!;
    int totalDayUsage=bloc.appUsageList[bloc.currDayIndex].totalUsage!.inMilliseconds;
    return ListView(
      padding: EdgeInsetsDirectional.symmetric(horizontal: width*0.05,vertical: height*0.015).copyWith(bottom: height*0.05),
      children: [
        Center(child: Text("Apps Usage",style: CustomTextStyle.fontBold21,)),
        SizedBox(height: height*0.02,),
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
                    Text("This Week",style: CustomTextStyle.fontNormal14.copyWith(color: Colors.white),),
                    const Icon(CupertinoIcons.arrow_turn_right_down,color: Colors.white,)
                  ],
                ),
              ),
              color: bottomNavBarColor,
            ),
          ],
        ),
        SizedBox(height: height*0.015,),
        CustomChart(height: height, width: width, bloc: bloc,),
        SizedBox(height: height*0.033,),
        Wrap(
          alignment: WrapAlignment.start,
          runSpacing: width*0.1,
          spacing: height*0.015,
          children: [
            ...List.generate(list.length, (index)=>CustomAppUsageItem(topAppModel: list[index], width: width,totalDayUsage: totalDayUsage,)),
          ],
        ),
      ],
    );
  }
}