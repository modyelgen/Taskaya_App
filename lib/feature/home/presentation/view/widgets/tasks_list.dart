import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:taskaya/core/utilites/app_theme/colors.dart';
import 'package:taskaya/core/utilites/app_theme/text_style.dart';
import 'package:taskaya/core/utilites/widgets/custom_big_button.dart';
import 'package:taskaya/feature/home/data/models/task_model.dart';
import 'package:taskaya/feature/home/presentation/manager/home_bloc.dart';
import 'package:taskaya/feature/home/presentation/view/widgets/task_item_widget/task_item.dart';
class TasksList extends StatelessWidget {
  const TasksList({
    super.key,
    required this.height,
    required this.width,
    required this.bloc,
  });

  final double height;
  final double width;
  final HomeBloc bloc;

  @override
  Widget build(BuildContext context) {
    List<TaskModel>missionList=bloc.filteredList.where((model)=>model.completed==0).toList();
    List<TaskModel>completeList=bloc.filteredList.where((model)=>model.completed==1).toList();
    return Expanded(
      child: SizedBox(
        height: height*0.6,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomBigButton(
              altWidth: width*0.33,
              color: bottomNavBarColor,
              borderRadius: 6,
              altWidget: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Mission",style: CustomTextStyle.fontBoldWhite16,),
                  IconButton(onPressed: (){},icon: Icon(CupertinoIcons.chevron_down,color: customBorderColor,))
                ],),),
            SizedBox(height: height*0.02,),
            missionList.isNotEmpty?Expanded(
              flex: 2,
              child: ListView.separated(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context,index){
                    return TaskItem(height: height, width: width,model: missionList[index],
                      taskQuery: bloc.querySearch,
                      moveTask: (){bloc.add(MoveTaskEvent(toComplete: true, taskID:missionList[index].taskID));},
                      removeTask: (){bloc.add(RemoveTaskEvent(isComplete: false, taskID:missionList[index].taskID));}
                      ,);
                  },
                  separatorBuilder: (context,index){
                    return SizedBox(
                      height: height*0.02,
                    );
                  },
                  itemCount: missionList.length),
            ) :
            Text("No Tasks Exist",style: CustomTextStyle.fontBold18,),
            SizedBox(height: height*0.02,),
            CustomBigButton(
              altWidth: width*0.33,
              color: bottomNavBarColor,
              borderRadius: 6,
              altWidget: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Completed",style: CustomTextStyle.fontBoldWhite16,),
                  IconButton(onPressed: (){},icon: Icon(CupertinoIcons.chevron_down,color: customBorderColor,))
                ],),),
            SizedBox(height: height*0.02,),
            completeList.isNotEmpty?Expanded(
              child: ListView.separated(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context,index){
                    return TaskItem(
                      taskQuery: bloc.querySearch,
                      height: height, width: width,model: completeList[index],
                      moveTask: (){bloc.add(MoveTaskEvent(toComplete: false, taskID: completeList[index].taskID));},
                      removeTask: (){bloc.add(RemoveTaskEvent(isComplete: true, taskID: completeList[index].taskID));},
                    );
                  },
                  separatorBuilder: (context,index){
                    return SizedBox(
                      height: height*0.02,
                    );
                  },
                  itemCount: completeList.length),
            ):
            Text("No Tasks Exist",style: CustomTextStyle.fontBold18,),
          ],
        ),
      ),
    );
  }
}