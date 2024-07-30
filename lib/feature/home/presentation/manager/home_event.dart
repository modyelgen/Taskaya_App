part of 'home_bloc.dart';


sealed class HomeEvent {}

final class LoadCustomDataEvent extends HomeEvent {}

class ChangeBottomNavIconEvent extends HomeEvent {
  int currIndex;
  ChangeBottomNavIconEvent({required this.currIndex});
}
final class CreateNewCategoryEvent extends HomeEvent {
  final CategoryModel model;
  CreateNewCategoryEvent({required this.model});
}

final class ChangeCurrFlagIndexEvent extends HomeEvent {
  final int index;
  final bool pick;
  ChangeCurrFlagIndexEvent({required this.index,required this.pick});
}

final class ChangeCurrCategoryIndexEvent extends HomeEvent {
  final int index;
  final bool pick;
  ChangeCurrCategoryIndexEvent({required this.index,required this.pick});
}

final class CreateNewTaskEvent extends HomeEvent {}

final class MoveTaskEvent extends HomeEvent {
  final String taskID;
  final bool toComplete;
  MoveTaskEvent({required this.toComplete,required this.taskID});
}
final class RemoveTaskEvent extends HomeEvent {
  final String taskID;
  RemoveTaskEvent({required this.taskID});
}

final class LoadTaskEvent extends HomeEvent {}

final class AllowToPopEvent extends HomeEvent {
  final bool allow;
  AllowToPopEvent({required this.allow});
}

final class SearchInTasksEvent extends HomeEvent {
  final String query;
  SearchInTasksEvent({this.query=""});
}

final class ChangeShowOfTaskEvent extends HomeEvent {
  final TaskTypesShowing type;
  ChangeShowOfTaskEvent({required this.type});
}
final class UpdateTaskEvent extends HomeEvent {
  final TaskModel model;
  UpdateTaskEvent({required this.model});
}
