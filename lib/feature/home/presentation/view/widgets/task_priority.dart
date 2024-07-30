import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskaya/core/utilites/app_theme/colors.dart';
import 'package:taskaya/core/utilites/app_theme/text_style.dart';
import 'package:taskaya/core/utilites/widgets/custom_big_button.dart';
import 'package:taskaya/feature/home/presentation/manager/home_bloc.dart';
import 'package:taskaya/feature/home/presentation/view/widgets/task_item_widget/priority_item.dart';

class TaskPriority extends StatelessWidget {
  const TaskPriority({super.key,required this.height,required this.width,required this.bloc});
  final double width;
  final double height;
  final HomeBloc bloc;
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Material(
        color: bottomNavBarColor,
        child: Container(
          width: width*0.9,
          height: height*0.5,
          padding:const EdgeInsetsDirectional.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: bottomNavBarColor,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("Task Priority",style: CustomTextStyle.fontBoldWhite16),
              SizedBox(
                width: width*0.75,
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
                            bloc.add(ChangeCurrFlagIndexEvent(index: index,pick: false));
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
                      bloc.add(ChangeCurrFlagIndexEvent(index: 0,pick: false));
                      Navigator.pop(context,null);
                    },child:Text("Cancel",style: CustomTextStyle.fontBold16.copyWith(color: buttonColor,decoration: TextDecoration.none),)),
                    CustomBigButton(
                      labelStyle: CustomTextStyle.fontBold18.copyWith(color: Colors.white),
                      label: "Save",
                      onTap: (){
                        bloc.add(ChangeCurrFlagIndexEvent(index: bloc.currFlag??0,pick: true));
                        Navigator.pop(context,bloc.currFlag);
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
      ),
    );
  }
}
