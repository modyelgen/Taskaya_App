import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskaya/core/utilites/app_theme/colors.dart';
import 'package:taskaya/core/utilites/app_theme/text_style.dart';
import 'package:taskaya/core/utilites/dimensions/responsive_layout.dart';
import 'package:taskaya/core/utilites/functions/extension.dart';
import 'package:taskaya/core/utilites/widgets/custom_big_button.dart';
import 'package:taskaya/feature/focus/data/model/focus_model.dart';
import 'package:taskaya/feature/focus/presentation/manager/focus_bloc.dart';
import 'package:taskaya/feature/focus/presentation/view/widgets/custom_chart.dart';

class FocusView extends StatelessWidget {
  const FocusView({super.key});

  @override
  Widget build(BuildContext context) {
    final double height=BasicDimension.screenHeight(context);
    final double width=BasicDimension.screenWidth(context);
    return BlocProvider(
      create: (context)=>FocusBloc()..add(InitialFocusEvent()),
      child: BlocConsumer<FocusBloc,FocusState>(
          builder: (context,state){
            var bloc=BlocProvider.of<FocusBloc>(context);
            return SafeArea(
              child: Scaffold(
                body: ListView(
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
                      child: ListView.separated(
                          itemBuilder: (context,index){
                            List<TopApps>list=bloc.appUsageList.first.topApps??[];
                            return ClipRRect(
                              borderRadius: BorderRadius.circular(4),
                              child: ColoredBox(
                                color: bottomNavBarColor,
                                child: ListTile(
                                  leading: const Icon(Icons.facebook),
                                  title: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text("${list[index].appName}"),
                                      Text("You spent ${list[index].timeUsage?.getFormattedDuration()} on Instagram today"),
                                    ],
                                  ),
                                  trailing: const Icon(Icons.warning),
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
          },
          listener: (context,state){}),
    );
  }
}











