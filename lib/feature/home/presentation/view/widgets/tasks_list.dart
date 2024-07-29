import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:taskaya/core/utilites/app_theme/colors.dart';
import 'package:taskaya/core/utilites/app_theme/text_style.dart';
import 'package:taskaya/core/utilites/widgets/custom_big_button.dart';
import 'package:taskaya/feature/home/presentation/manager/home_bloc.dart';
import 'package:taskaya/feature/home/presentation/view/widgets/task_item.dart';
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
    return Expanded(
      child: SizedBox(
        height: height*0.6,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomBigButton(
              color: bottomNavBarColor,
              borderRadius: 6,
              altWidget: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Mission",style: CustomTextStyle.fontBoldWhite16,),
                  IconButton(onPressed: (){},icon: Icon(CupertinoIcons.chevron_down,color: customBorderColor,))
                ],),),
            SizedBox(height: height*0.02,),
            bloc.taskList.isNotEmpty?Expanded(
              flex: 2,
              child: ListView.separated(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context,index){
                    return TaskItem(height: height, width: width,model: bloc.taskList[index],
                      moveTask: (){bloc.add(MoveTaskEvent(toComplete: true, index: index));},
                      removeTask: (){bloc.add(RemoveTaskEvent(isComplete: false, index: index));}
                      ,);
                  },
                  separatorBuilder: (context,index){
                    return SizedBox(
                      height: height*0.02,
                    );
                  },
                  itemCount: bloc.taskList.length),
            )
                :const SizedBox(),
            SizedBox(height: height*0.02,),
            CustomBigButton(
              color: bottomNavBarColor,
              borderRadius: 6,
              altWidget: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Completed",style: CustomTextStyle.fontBoldWhite16,),
                  IconButton(onPressed: (){},icon: Icon(CupertinoIcons.chevron_down,color: customBorderColor,))
                ],),),
            SizedBox(height: height*0.02,),
            bloc.completedList.isNotEmpty?Expanded(
              child: ListView.separated(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context,index){
                    return TaskItem(height: height, width: width,model: bloc.completedList[index],
                      moveTask: (){bloc.add(MoveTaskEvent(toComplete: false, index: index));},
                      removeTask: (){bloc.add(RemoveTaskEvent(isComplete: true, index: index));},
                    );
                  },
                  separatorBuilder: (context,index){
                    return SizedBox(
                      height: height*0.02,
                    );
                  },
                  itemCount: bloc.completedList.length),
            ):
            const SizedBox(),
          ],
        ),
      ),
    );
  }
}