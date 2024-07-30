import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:taskaya/core/utilites/app_theme/colors.dart';
import 'package:taskaya/core/utilites/app_theme/text_style.dart';
import 'package:taskaya/core/utilites/widgets/custom_text_form_field.dart';
import 'package:taskaya/feature/home/presentation/manager/edit_task/edit_task_cubit.dart';

class EditTextDescCompleteness extends StatelessWidget {
  const EditTextDescCompleteness({
    super.key,
    required this.width,
    required this.cubit,
  });

  final double width;
  final EditTaskCubit cubit;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Align(
          child: SizedBox(
              width: width*0.1,
              child: IconButton(onPressed: (){cubit.updateCompleteness();}, icon: Icon(cubit.tempModel.completed==0?CupertinoIcons.circle:CupertinoIcons.checkmark_circle,color:customBorderColor,))),
        ),
        SizedBox(width: width*0.05,),
        Column(
          children: [
            SizedBox(
              width: width*0.6,
              child: CustomTextFormField(label: "Task",enableNormalBorder: false,style: CustomTextStyle.fontNormal16.copyWith(color: Colors.white),enableEnabledBorder: false,border: 8,borderWidth: 1,controller: cubit.taskController,onChanged: (value){
                cubit.updateTaskText(value);
              },),
            ),
            SizedBox(
              width: width*0.6,
              child: CustomTextFormField(label: "Description",style: CustomTextStyle.fontNormal14.copyWith(color: Colors.white),enableNormalBorder: false,enableEnabledBorder: false,border: 8,borderWidth: 1,controller: cubit.descController,onChanged: (value){
                cubit.updateDescText(value);
              },),
            ),
          ],
        ),
        SizedBox(width: width*0.05,),
        IconButton(onPressed: null, icon: Icon(Icons.mode_edit_outline_outlined,color: customBorderColor,))
      ],
    );
  }
}