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
  ChangeCurrFlagIndexEvent({required this.index});
}

final class AllowToPopEvent extends HomeEvent {
  final bool allow;
  AllowToPopEvent({required this.allow});
}
