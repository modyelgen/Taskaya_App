import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskaya/core/utilites/app_theme/colors.dart';
import 'package:taskaya/core/utilites/app_theme/text_style.dart';
import 'package:taskaya/core/utilites/widgets/custom_big_button.dart';
import 'package:taskaya/feature/home/presentation/manager/home_bloc.dart';
import 'package:taskaya/feature/home/presentation/view/widgets/priority_item.dart';

class TaskPriority extends StatelessWidget {
  const TaskPriority({super.key,required this.height,required this.width,required this.bloc});
  final double width;
  final double height;
  final HomeBloc bloc;
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        height: height*0.5,
        padding:const EdgeInsetsDirectional.symmetric(vertical: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: bottomNavBarColor,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("Task Priority",style: CustomTextStyle.fontBoldWhite16),
            SizedBox(
              width: width*0.9,
              child: Divider(
                thickness: 1,
                color: customBorderColor,
              ),
            ),
            SizedBox(height: height*0.015,),
            BlocBuilder<HomeBloc,HomeState>(
              bloc: bloc,
              builder: (context,state) {
                return Wrap(
                  spacing: height*0.02,
                  runSpacing: width*0.05,
                  children: [
                    ...List.generate(10, (index)=>GestureDetector(
                        onTap: (){
                          bloc.add(ChangeCurrFlagIndexEvent(index: index));
                        },
                        child: PriorityItem(index: index,width: width,height: height,curr: index==bloc.currFlag,)))
                  ],
                );
              }
            ),
            SizedBox(height: height*0.015,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: width*0.025,
                  ),
                  TextButton(onPressed: (){
                    Navigator.pop(context);
                  },child:Text("Cancel",style: CustomTextStyle.fontBold16.copyWith(color: buttonColor,decoration: TextDecoration.none),)),
                  CustomBigButton(
                    labelStyle: CustomTextStyle.fontBold18.copyWith(color: Colors.white),
                    label: "Save",
                    onTap: (){
                      Navigator.pop(context);
                    },
                    borderRadius: 8,
                    color: buttonColor,
                    altWidth: width*0.4,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

