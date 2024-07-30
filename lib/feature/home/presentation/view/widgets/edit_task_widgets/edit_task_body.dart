import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:taskaya/core/utilites/app_theme/colors.dart';
import 'package:taskaya/core/utilites/app_theme/text_style.dart';
import 'package:taskaya/core/utilites/widgets/custom_big_button.dart';
import 'package:taskaya/core/utilites/widgets/warning_option.dart';
import 'package:taskaya/feature/home/presentation/manager/edit_task/edit_task_cubit.dart';
import 'package:taskaya/feature/home/presentation/manager/home_bloc.dart';
import 'package:taskaya/feature/home/presentation/view/widgets/edit_task_widgets/task_desc_complete.dart';

import 'change_cat_time.dart';
class EditTaskBody extends StatelessWidget {
  const EditTaskBody({
    super.key,
    required this.width,
    required this.height,
    required this.cubit,
    required this.bloc,
  });

  final double width;
  final double height;
  final EditTaskCubit cubit;
  final HomeBloc bloc;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Padding(
          padding: EdgeInsetsDirectional.all(width*0.025),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButton(onPressed: (){Navigator.pop(context);},icon:Icon(CupertinoIcons.xmark,color: customBorderColor,),),
              SizedBox(height: height*0.0125,),
              EditTextDescCompleteness(width: width, cubit: cubit),
              SizedBox(height: height*0.015,),

              ChangeTimeCategoryPriority(height: height, cubit: cubit, width: width, bloc: bloc),
              SizedBox(height: height*0.0125,),
              ListTile(
                  title: Text("Delete Task",style: CustomTextStyle.fontNormal14.copyWith(color: deleteColor),),
                  leading: IconButton(onPressed: (){
                    showConfirmDialog(context).then((value){
                      cubit.deleteTask(check: value);
                    });
                  },icon: Icon(CupertinoIcons.delete,color: deleteColor,),)
              ),
              const Spacer(),
              Center(child: CustomBigButton(onTap: ()async{
                cubit.confirmToUpdate();
                Navigator.pop(context);
              },altWidth: width*0.8,label: "Edit Task",labelStyle: CustomTextStyle.fontBoldWhite16,color: buttonColor,borderRadius: 8,)),
            ],
          ),
        ),
      ),
    );
  }
}
