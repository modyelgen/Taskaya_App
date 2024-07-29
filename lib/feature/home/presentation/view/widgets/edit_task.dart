import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:taskaya/core/utilites/app_theme/colors.dart';
import 'package:taskaya/core/utilites/app_theme/text_style.dart';
import 'package:taskaya/core/utilites/widgets/custom_big_button.dart';
import 'package:taskaya/core/utilites/widgets/custom_text_form_field.dart';
import 'package:taskaya/feature/home/data/models/task_model.dart';
import 'package:taskaya/feature/home/presentation/view/widgets/task_item_widget/one_category_in_task.dart';
import 'package:taskaya/feature/home/presentation/view/widgets/task_item_widget/one_priority_in_task.dart';
import 'package:taskaya/feature/home/presentation/view/widgets/task_item_widget/one_time_in_task.dart';

class EditTaskView extends StatelessWidget {
  const EditTaskView({super.key,required this.width,required this.height,required this.model});
  final double width;
  final double height;
  final TaskModel model;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Material(
        child: SizedBox(
          width: width,
          child: Padding(
            padding: EdgeInsetsDirectional.all(width*0.025),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconButton(onPressed: (){Navigator.pop(context);},icon:Icon(CupertinoIcons.xmark,color: customBorderColor,),),
                SizedBox(height: height*0.0125,),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Align(
                      child: SizedBox(
                          width: width*0.1,
                          child: IconButton(onPressed: null, icon: Icon(model.completed==0?CupertinoIcons.circle:CupertinoIcons.checkmark_circle,color:customBorderColor,))),
                    ),
                    SizedBox(width: width*0.05,),
                    Column(
                      children: [
                        SizedBox(
                          height: height*0.06,
                          width: width*0.6,
                          child: CustomTextFormField(label: "Task",enableNormalBorder: false,style: CustomTextStyle.fontNormal16.copyWith(color: Colors.white),enableEnabledBorder: false,border: 8,borderWidth: 1,),
                        ),
                        SizedBox(
                          height: height*0.06,
                          width: width*0.6,
                          child: CustomTextFormField(label: "Description",style: CustomTextStyle.fontNormal14.copyWith(color: Colors.white),enableNormalBorder: false,enableEnabledBorder: false,border: 8,borderWidth: 1,),
                        ),
                      ],
                    ),
                    SizedBox(width: width*0.05,),
                    IconButton(onPressed: null, icon: Icon(Icons.mode_edit_outline_outlined,color: customBorderColor,))
                  ],
                ),
                SizedBox(height: height*0.015,),
                SizedBox(
                  height: height*0.3,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ListTile(
                        leading:const Icon(Icons.timer_sharp),
                        title: Text("Task Time:",style: CustomTextStyle.fontBold16,),
                        trailing: model.taskTime!=null?CustomBigButton(altWidget:OneTextInTaskItem(model: model.taskTime!),borderRadius: 6,altWidth: width*0.3,color: bottomNavBarColor,):
                        const AddButtonToTask(),
                      ),
                      ListTile(
                          leading:const Icon(CupertinoIcons.tags),
                          title: Text("Task Category:",style: CustomTextStyle.fontBold16,),
                          trailing: model.taskCategory!=null?OneCategoryInTask(model: model.taskCategory!, width: width,enableWidth: true,) :
                          const AddButtonToTask(),
                      ),
                      ListTile(
                        leading:const Icon(CupertinoIcons.flag),
                        title: Text("Task Priority:",style: CustomTextStyle.fontBold16,),
                        trailing: model.priority!=null?OnePriorityInTask(width: width*0.4, priority: model.priority!,enableWidth: true,):
                        const AddButtonToTask(),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: height*0.0125,),
                ListTile(
                  title: Text("Delete Task",style: CustomTextStyle.fontNormal14.copyWith(color: deleteColor),),
                  leading: IconButton(onPressed: null,icon: Icon(CupertinoIcons.delete,color: deleteColor,),)
                ),
                const Spacer(),
                Center(child: CustomBigButton(altWidth: width*0.8,label: "Edit Task",labelStyle: CustomTextStyle.fontBoldWhite16,color: buttonColor,borderRadius: 8,)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class AddButtonToTask extends StatelessWidget {
  const AddButtonToTask({
    super.key,
    this.onTap
  });
  final void Function()?onTap;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(onPressed: onTap,style: ElevatedButton.styleFrom(backgroundColor: bottomNavBarColor,shape:const CircleBorder()), child: const Icon(CupertinoIcons.add),);
  }
}
