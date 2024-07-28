import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:taskaya/core/utilites/app_theme/colors.dart';
import 'package:taskaya/core/utilites/app_theme/text_style.dart';
import 'package:taskaya/core/utilites/widgets/custom_text_form_field.dart';
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
            child: const CustomTextFormField(label: "Task",enableNormalBorder: false,enableEnabledBorder: false,border: 8,),
          ),
          SizedBox(
            height: height*0.06,
            child: const CustomTextFormField(label: "Description",enableNormalBorder: false,enableEnabledBorder: false,border: 8,),
          ),
          SizedBox(
            height: height*0.015,
          ),
           Row(
            children: [
              IconButton(
                  onPressed: ()async{
                    await showDatePicker(
                      context: context, firstDate: DateTime.now(),
                      confirmText: "Choose Time",
                      cancelText: "Cancel",
                      lastDate: DateTime.now().copyWith(month: DateTime.now().month+4),).then((value)async{
                        if(value!=null){
                          await showTimePicker(context: context, initialTime: TimeOfDay.now(),);
                        }
                      });
              },icon:const Icon(Icons.timer_sharp),tooltip: " Task Time",),

              IconButton(onPressed: ()async{
                //bloc.add(ChangeEnablePickCategoryEvent());
               await showGeneralDialog(
                    context: context,
                    barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
                    pageBuilder: (context,animation,ani){
                  return Center(child: TaskCategory(height: height, width: width,bloc: bloc,));
                });
              },icon:const Icon(CupertinoIcons.tags,)),

              IconButton(onPressed: ()async{
                await showGeneralDialog(
                    context: context,
                    barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
                    pageBuilder: (context,Animation sec,Animation pr){
                      return Center(child: TaskPriority(height: height, width: width,bloc:bloc));
                });
              },icon:const Icon(CupertinoIcons.flag)),

              const Spacer(),
              Transform.rotate(
                  angle: 45 * 3.1415927 / 180,
                  child:Icon(CupertinoIcons.paperplane,color: buttonColor,))
            ],
          ),
        ],
      ),
    );
  }
}
