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
  final int index;
  final bool toComplete;
  MoveTaskEvent({required this.toComplete,required this.index});
}
final class RemoveTaskEvent extends HomeEvent {
  final int index;
  final bool isComplete;
  RemoveTaskEvent({required this.isComplete,required this.index});
}

final class LoadTaskEvent extends HomeEvent {}

final class AllowToPopEvent extends HomeEvent {
  final bool allow;
  AllowToPopEvent({required this.allow});
}
