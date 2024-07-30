import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:taskaya/core/utilites/app_theme/colors.dart';
import 'package:taskaya/core/utilites/app_theme/text_style.dart';
import 'package:taskaya/core/utilites/widgets/custom_big_button.dart';
import 'package:taskaya/feature/home/presentation/manager/edit_task/edit_task_cubit.dart';
import 'package:taskaya/feature/home/presentation/manager/home_bloc.dart';
import 'package:taskaya/feature/home/presentation/view/widgets/add_task_pop.dart';
import 'package:taskaya/feature/home/presentation/view/widgets/edit_task_widgets/add_button_widget.dart';
import 'package:taskaya/feature/home/presentation/view/widgets/task_item_widget/one_category_in_task.dart';
import 'package:taskaya/feature/home/presentation/view/widgets/task_item_widget/one_priority_in_task.dart';
import 'package:taskaya/feature/home/presentation/view/widgets/task_item_widget/one_time_in_task.dart';

class ChangeTimeCategoryPriority extends StatelessWidget {
  const ChangeTimeCategoryPriority({
    super.key,
    required this.height,
    required this.cubit,
    required this.width,
    required this.bloc,
  });

  final double height;
  final EditTaskCubit cubit;
  final double width;
  final HomeBloc bloc;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height*0.3,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ListTile(
            leading:const Icon(Icons.timer_sharp),
            title: Text("Task Time:",style: CustomTextStyle.fontBold16,),
            trailing: GestureDetector(
              onTap: ()async{
                await showDatePicker(
                  context: context,
                  barrierDismissible: false,
                  firstDate: cubit.tempModel.taskTime?.dayDate??DateTime.now(),
                  confirmText: "Choose Time",
                  cancelText: "Cancel",
                  initialDate:cubit.tempModel.taskTime?.dayDate??DateTime.now(),
                  lastDate: DateTime.now().copyWith(month: DateTime.now().month+4),).then((dayValue)async{
                  if(dayValue!=null){
                    await showTimePicker(context: context,barrierDismissible: false,initialTime:cubit.tempModel.taskTime?.dayHourMinute??TimeOfDay.now(),).then((hourValue){
                      if(hourValue!=null){
                        cubit.updateTime(dayTime: hourValue, date: dayValue);
                      }
                    });
                  }
                });
              },
              child:cubit.tempModel.taskTime!=null? CustomBigButton(altWidget:OneTextInTaskItem(model: cubit.tempModel.taskTime!),borderRadius: 6,altWidth: width*0.3,color: bottomNavBarColor,):
              const AddButtonToTask(),),
          ),
          ListTile(
            leading:const Icon(CupertinoIcons.tags),
            title: Text("Task Category:",style: CustomTextStyle.fontBold16,),
            trailing: GestureDetector(
              onTap: ()async{
                await showCategoryPicker(context: context, bloc: bloc, height: height, width: width).then((value){
                  if(value!=null){
                    cubit.updateCategory(model: value);
                  }
                });
              },
              child:cubit.tempModel.taskCategory!=null? OneCategoryInTask(model: cubit.tempModel.taskCategory!, width: width,enableWidth: true,) :
              const AddButtonToTask(),
            ),),
          ListTile(
            leading:const Icon(CupertinoIcons.flag),
            title: Text("Task Priority:",style: CustomTextStyle.fontBold16,),
            trailing: GestureDetector(
              onTap: ()async{
                await showPriorityPicker(context: context, bloc: bloc, height: height, width: width).then((value){
                  if(value!=null){
                    cubit.updatePriority(priority: value);
                  }
                });
              },
              child:cubit.tempModel.priority!=null? OnePriorityInTask(width: width*0.4, priority: cubit.tempModel.priority!,enableWidth: true,):
              const AddButtonToTask(),
            ),)
        ],
      ),
    );
  }
}