import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:taskaya/core/utilites/app_theme/colors.dart';
import 'package:taskaya/core/utilites/app_theme/text_style.dart';
import 'package:taskaya/core/utilites/functions/get_related_color.dart';
import 'package:taskaya/core/utilites/functions/icon_to_string.dart';
import 'package:taskaya/core/utilites/widgets/custom_big_button.dart';
import 'package:taskaya/core/utilites/widgets/warning_option.dart';
import 'package:taskaya/feature/home/data/models/task_model.dart';

class TaskItem extends StatelessWidget {
  const TaskItem({super.key,required this.height,required this.width,required this.model,this.removeTask,this.moveTask});
  final double width;
  final double height;
  final TaskModel model;
  final void Function()?removeTask;
  final void Function()?moveTask;
  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key:UniqueKey(),
      confirmDismiss: (direction)async{
        bool confirm=await showConfirmDialog(context);
        return confirm;
      },
      onDismissed: (direction){
        removeTask==null?null:removeTask!();
      },
      direction: DismissDirection.startToEnd,
      background: CustomBigButton(altWidth: width,color: deleteColor,borderRadius: 8,altWidget:const IconButton(onPressed: null,icon:Icon(Icons.delete,color: Colors.white,)),mainAxisAlignment: MainAxisAlignment.start,),
      child: Container(
        padding: EdgeInsetsDirectional.all(width*0.01),
        width: width,
        height: height*0.1,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: bottomNavBarColor,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
                width: width*0.1,
                child: IconButton(onPressed: moveTask, icon: Icon(model.completed==0?CupertinoIcons.circle:CupertinoIcons.checkmark_circle,color:customBorderColor ,))),
            Expanded(
              child: SizedBox(
                width: width*0.75,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(model.taskName,style: CustomTextStyle.fontNormal16.copyWith(color: Colors.white),),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                            width: width*0.3,
                            child:model.taskTime!=null?Text("${getFormattedDay(model.taskTime?.dayDate)??""} At ${model.taskTime?.dayHourMinute?.hour??""}:${model.taskTime?.dayHourMinute?.minute??""}",style: CustomTextStyle.fontNormal14.copyWith(color: customBorderColor),maxLines: 2,overflow: TextOverflow.ellipsis,):null),
                        SizedBox(
                          width: width*0.45,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              if(model.taskCategory!=null)CustomBigButton(
                                color: model.taskCategory?.color,
                                altWidth: width*0.27,
                                borderRadius: 4,
                                altWidget:  Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Icon(model.taskCategory?.icon,color: getRelatedColor(model.taskCategory!.color!),),
                                    const SizedBox(width: 4,),
                                    SizedBox(
                                      width: width*0.2,
                                      child: Text(model.taskCategory!.name!,style: CustomTextStyle.fontBoldWhite16.copyWith(fontSize: 14,overflow: TextOverflow.ellipsis),maxLines: 1,),
                                    ),
                                  ],
                                ),),
                              const SizedBox(),
                              if(model.priority!=null)CustomBigButton(
                                altWidth: width*0.12,
                                borderRadius: 4,
                                color: bottomNavBarColor,
                                boxBorder: Border.all(color: buttonColor,width: 2,),
                                altWidget:  Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Icon(CupertinoIcons.flag,color: Colors.white,),
                                    Text("${model.priority??""}",style: CustomTextStyle.fontBoldWhite16.copyWith(fontSize: 12),),
                                  ],
                                ),)
                            ],
                          ),
                        ),

                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

