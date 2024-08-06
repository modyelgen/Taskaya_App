part of 'focus_bloc.dart';

@immutable
sealed class FocusState {}

final class FocusInitialState extends FocusState {}

final class FocusLoadingAppsUsageState extends FocusState {}

final class FocusSuccessAppsUsageState extends FocusState {}

final class FocusFailureAppsUsageState extends FocusState {
  final String?errMessage;
  FocusFailureAppsUsageState({this.errMessage});
}