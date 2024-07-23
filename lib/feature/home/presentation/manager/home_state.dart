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
