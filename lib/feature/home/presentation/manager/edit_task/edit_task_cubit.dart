import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskaya/feature/home/data/models/task_model.dart';
part 'edit_task_state.dart';

class EditTaskCubit extends Cubit<EditTaskState> {
  EditTaskCubit({required this.model}) : super(EditTaskInitialState());
  TaskModel model;
  TaskModel tempModel=TaskModel(taskName: "", taskID: "");
  TextEditingController taskController=TextEditingController();
  TextEditingController descController=TextEditingController();
  void initTaskWithTemp()async{
    taskController.text=model.taskName;
    descController.text=model.taskDescription??"";
    tempModel=TaskModel.transfer(model: model);
    emit(InitTaskState());
  }
  void updateTime({required TimeOfDay dayTime,required DateTime date}){
    tempModel.taskTime=date.copyWith(hour:dayTime.hour ,minute:dayTime.minute);
    emit(UpdateTaskState());
  }
  void updateCategory({required CategoryModel model}){
    tempModel.taskCategory=model;
    emit(UpdateTaskState());
  }
  void updatePriority({required int priority}){
    tempModel.priority=priority;
    emit(UpdateTaskState());
  }
  void updateCompleteness(){
    tempModel.completed==0? tempModel.completed=1:tempModel.completed=0;
    emit(UpdateTaskState());
  }
  void deleteTask({required bool check }){
    if(check) {
      emit(ConfirmToDeleteTaskState(id: model.taskID));
    }
  }
  void confirmToUpdate()async{
    emit(ConfirmToUpdateTaskState(model: tempModel));
  }
  void updateTaskText(String value){
    if(value.isNotEmpty&&value.trim().isNotEmpty){
      tempModel.taskName=value;
    }
  }
  void updateDescText(String value){
    if(value.isNotEmpty&&value.trim().isNotEmpty){
      tempModel.taskDescription=value;
    }
  }
}
