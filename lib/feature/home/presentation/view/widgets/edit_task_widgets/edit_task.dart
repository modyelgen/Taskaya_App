import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskaya/feature/home/data/models/task_model.dart';
import 'package:taskaya/feature/home/presentation/manager/edit_task/edit_task_cubit.dart';
import 'package:taskaya/feature/home/presentation/manager/home_bloc.dart';
import 'package:taskaya/feature/home/presentation/view/widgets/edit_task_widgets/edit_task_body.dart';

class EditTaskView extends StatelessWidget {
  const EditTaskView({super.key,required this.width,required this.height,required this.model,required this.bloc});
  final double width;
  final double height;
  final TaskModel model;
  final HomeBloc bloc;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context)=>EditTaskCubit(model: model)..initTaskWithTemp(),
      child: BlocConsumer<EditTaskCubit,EditTaskState>(
          builder: (context,state){
            var cubit=BlocProvider.of<EditTaskCubit>(context);
            return EditTaskBody(width: width, height: height, cubit: cubit, bloc: bloc);
          },
          listener: (context,state){
            if(state is ConfirmToDeleteTaskState) {
              bloc.add(RemoveTaskEvent(taskID: state.id));
              Navigator.pop(context);
            }
            else if(state is ConfirmToUpdateTaskState){
              bloc.add(UpdateTaskEvent(model:state.model));
            }
          }),
    );
  }
}






