part of 'home_bloc.dart';

@immutable
sealed class HomeState {}

final class HomeInitialState extends HomeState {}

final class ChangeBottomIconState extends HomeState {}

final class LoadCustomDataSuccess extends HomeState {}

final class LoadCustomDataFailed extends HomeState {
  final String?errMessage;
  LoadCustomDataFailed({this.errMessage});
}

final class AddNewCategoryState extends HomeState {}

final class EnablePickCategoryState extends HomeState {}

final class ChangeFlagIndexState extends HomeState {}

final class ChangeCategoryIndexState extends HomeState {}

final class ChangeNavigationToPopState extends HomeState {}

final class LoadNewCategorySuccessState extends HomeState {}

final class LoadNewCategoryFailureState extends HomeState {
  final String?errMessage;
  LoadNewCategoryFailureState({this.errMessage});
}

final class SuccessAddNewTaskState extends HomeState {}

final class MoveTaskState extends HomeState {}

final class RemoveTaskState extends HomeState {}

final class ChangeTaskAccordingToSearchState extends HomeState {}

final class ChangeShowOfTaskState extends HomeState {}

final class LoadingLoadTaskListState extends HomeState {}

final class SuccessLoadTaskListState extends HomeState {}

final class FailureLoadTaskListState extends HomeState {
  final String?errMessage;
  FailureLoadTaskListState({this.errMessage});
}
