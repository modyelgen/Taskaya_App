import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:taskaya/core/utilites/app_theme/colors.dart';
import 'package:taskaya/core/utilites/app_theme/text_style.dart';
import 'package:taskaya/core/utilites/widgets/custom_text_form_field.dart';
import 'package:taskaya/core/utilites/widgets/leave_app.dart';
import 'package:taskaya/feature/home/presentation/manager/home_bloc.dart';
import 'package:taskaya/feature/home/presentation/view/widgets/task_category.dart';
import 'package:taskaya/feature/home/presentation/view/widgets/task_priority.dart';

class AddTaskPop extends StatelessWidget {
  const AddTaskPop({super.key,required this.height,required this.width,required this.bloc});
  final double width;
  final double height;
  final HomeBloc bloc;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding:const EdgeInsets.all(16),
      width: width,
      height: height*0.27,
      decoration: BoxDecoration(
        color: bottomNavBarColor,
        borderRadius: const BorderRadius.only(topRight: Radius.circular(16),topLeft: Radius.circular(16)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Add Task",style: CustomTextStyle.fontBoldWhite16,),
          SizedBox(
            height: height*0.06,
            child: CustomTextFormField(label: "Task",enableNormalBorder: false,style: CustomTextStyle.fontNormal16.copyWith(color: Colors.white),enableEnabledBorder: false,border: 8,borderWidth: 1,controller: bloc.taskController,),
          ),
          SizedBox(
            height: height*0.06,
            child: CustomTextFormField(label: "Description",style: CustomTextStyle.fontNormal14.copyWith(color: Colors.white),enableNormalBorder: false,enableEnabledBorder: false,border: 8,borderWidth: 1,controller: bloc.describeController),
          ),
          SizedBox(
            height: height*0.015,
          ),
           Row(
            children: [
              IconButton(
                  onPressed: ()async{
                    await showDatePicker(
                      context: context,
                      barrierDismissible: false,
                      firstDate: DateTime.now(),
                      confirmText: "Choose Time",
                      cancelText: "Cancel",
                      initialDate:bloc.taskTimeModel?.dayDate??DateTime.now(),
                      lastDate: DateTime.now().copyWith(month: DateTime.now().month+4),).then((dayValue)async{
                        if(dayValue!=null){
                          await showTimePicker(context: context,barrierDismissible: false,initialTime:bloc.taskTimeModel?.dayHourMinute??TimeOfDay.now(),).then((hourValue){
                            if(hourValue!=null){
                              bloc.changeDayTime(dayTime:dayValue,hourTime:hourValue);
                            }
                          });
                        }
                      });
              },icon:Icon(Icons.timer_sharp,color:customBorderColor),tooltip: " Task Time",),

              IconButton(onPressed: ()async{
                await showGeneralDialog(
                    context: context,
                    barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
                    pageBuilder: (context,animation,ani){
                  return Center(child: TaskCategory(height: height, width: width,bloc: bloc,));
                });
              },icon:Icon(CupertinoIcons.tags,color: customBorderColor,),tooltip: "Task Category",),

              IconButton(onPressed: ()async{
                await showGeneralDialog(
                    context: context,
                    barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
                    pageBuilder: (context,Animation sec,Animation pr){
                      return Center(child: TaskPriority(height: height, width: width,bloc:bloc));
                });
              },icon:Icon(CupertinoIcons.flag,color:customBorderColor),tooltip: "Task Priority",),

              const Spacer(),
              IconButton(onPressed: (){
                bloc.add(CreateNewTaskEvent());
                Navigator.pop(context);
              },icon:Icon(CupertinoIcons.paperplane,color: buttonColor,).rotate(angle: 45)),
            ],
          ),
        ],
      ),
    );
  }
}
