import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:taskaya/core/utilites/app_theme/colors.dart';
import 'package:taskaya/core/utilites/app_theme/text_style.dart';
import 'package:taskaya/core/utilites/widgets/custom_big_button.dart';
import 'package:taskaya/core/utilites/widgets/warning_option.dart';
import 'package:taskaya/feature/home/data/models/task_model.dart';
import 'package:taskaya/feature/home/presentation/view/widgets/edit_task.dart';
import 'package:taskaya/feature/home/presentation/view/widgets/task_item_widget/one_category_in_task.dart';
import 'package:taskaya/feature/home/presentation/view/widgets/task_item_widget/one_priority_in_task.dart';
import 'package:taskaya/feature/home/presentation/view/widgets/task_item_widget/one_time_in_task.dart';

class TaskItem extends StatelessWidget {
  const TaskItem({super.key,required this.height,required this.width,required this.model,this.removeTask,this.moveTask,this.taskQuery=''});
  final double width;
  final double height;
  final TaskModel model;
  final String taskQuery;
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
      child: GestureDetector(
        onTap: (){
          showGeneralDialog(context: context, pageBuilder: (context,anu,an){
            return EditTaskView(width: width, height: height,model: model,);
          });
        },
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
                      SizedBox(
                          width: width*0.7,
                          child:TaskItemTextWithSearchedQuery(taskText: model.taskName, taskQuery: taskQuery,),),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                              width: width*0.3,
                              child:model.taskTime!=null?OneTextInTaskItem(model: model.taskTime!):null),
                          SizedBox(
                            width: width*0.4,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                if(model.taskCategory!=null)OneCategoryInTask(model: model.taskCategory!, width: width),
                                const SizedBox(),
                                if(model.priority!=null)OnePriorityInTask(width: width, priority: model.priority!)
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
      ),
    );
  }
}
class TaskItemTextWithSearchedQuery extends StatelessWidget {
  const TaskItemTextWithSearchedQuery({super.key,required this.taskText,required this.taskQuery});
  final String taskText;
  final String taskQuery;
  @override
  Widget build(BuildContext context) {
    if (taskQuery.isEmpty) {
      return Text(taskText,style: CustomTextStyle.fontNormal16.copyWith(color: Colors.white),maxLines: 1,overflow: TextOverflow.ellipsis,);
    }

    // Find the position of the query in the text
    int startIndex = taskText.toLowerCase().indexOf(taskQuery.toLowerCase());
    if (startIndex == -1) {
      return Text(taskText,style: CustomTextStyle.fontNormal16.copyWith(color: Colors.white),maxLines: 1,overflow: TextOverflow.ellipsis,);
    }

    // Split the text into parts: before, query, and after
    String beforeQuery = taskText.substring(0, startIndex);
    String matchingQuery = taskText.substring(startIndex, startIndex + taskQuery.length);
    String afterQuery = taskText.substring(startIndex + taskQuery.length);

    return Text.rich(
      TextSpan(
        children: [
          TextSpan(text: beforeQuery,style: CustomTextStyle.fontNormal16.copyWith(color: Colors.white,overflow: TextOverflow.ellipsis),),
          TextSpan(
            text: matchingQuery,
            style: CustomTextStyle.fontNormal16.copyWith(color: customBorderColor,overflow: TextOverflow.ellipsis,decoration:TextDecoration.underline,), // Underline and color the query
          ),
          TextSpan(text: afterQuery),
        ],
      ),
    );
  }
}






