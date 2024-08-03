import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskaya/core/utilites/dimensions/responsive_layout.dart';
import 'package:taskaya/feature/calendar/presentation/manager/calendar_bloc.dart';
import 'package:taskaya/feature/calendar/presentation/view/custom_calendar_picker.dart';
import 'package:taskaya/feature/home/data/models/task_model.dart';
import 'package:taskaya/feature/home/presentation/manager/home_bloc.dart';
import 'package:taskaya/feature/home/presentation/view/widgets/task_item_widget/task_item.dart';

class CalendarView extends StatelessWidget {
  const CalendarView({super.key,required this.taskList,required this.homeBloc});
  final List<TaskModel>taskList;
  final HomeBloc homeBloc;
  @override
  Widget build(BuildContext context) {
    final double width=BasicDimension.screenWidth(context);
    final double height=BasicDimension.screenHeight(context);

    return BlocProvider(
      create: (context)=>CalendarBloc(taskList: taskList,homeBloc: homeBloc,)..add(InitialCalendarEvent()),
      child: BlocConsumer<CalendarBloc,CalendarState>(
          builder: (context,state){
            var bloc=BlocProvider.of<CalendarBloc>(context);
            return  SafeArea(
              child: Scaffold(
                body: Column(
                  children: [
                    bloc.isLoading?const SizedBox():
                    CustomCalendarWidget(width: width, bloc: bloc, height: height),
                    SizedBox(height: height*0.025,),
                    Expanded(
                      child: SizedBox(
                        height: height*0.5,
                        child: ListView.separated(
                          separatorBuilder: (context,index){
                            return SizedBox(height: height*0.0125,);
                          },
                          padding: EdgeInsetsDirectional.all(width*0.025),
                          itemCount: bloc.filteredList.length,
                          itemBuilder: (context,index){
                            return TaskItem(height: height, width: width, model: bloc.filteredList[index], bloc: homeBloc);
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
          listener: (context,state){
            // var bloc=BlocProvider.of<CalendarBloc>(context);
            // if(state is SuccessAddNewTaskState){
            //   bloc.add(RefreshCalendarListEvent());
            // }
          }),
    );
  }
}




