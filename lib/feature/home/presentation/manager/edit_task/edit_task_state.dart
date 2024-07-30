part of 'edit_task_cubit.dart';

@immutable
sealed class EditTaskState {}

final class EditTaskInitialState extends EditTaskState {}

final class InitTaskState extends EditTaskState {}

final class UpdateTaskState extends EditTaskState {}

final class ConfirmToUpdateTaskState extends EditTaskState {
  final TaskModel model;
  ConfirmToUpdateTaskState({required this.model});
}

final class ConfirmToDeleteTaskState extends EditTaskState {
  final String id;
  ConfirmToDeleteTaskState({required this.id});
}
