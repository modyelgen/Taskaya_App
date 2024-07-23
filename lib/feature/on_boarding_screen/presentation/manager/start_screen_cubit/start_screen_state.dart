part of 'start_screen_cubit.dart';

@immutable
sealed class StartScreenState {}

final class StartScreenInitial extends StartScreenState {}

final class ChangeProfilePictureState extends StartScreenState {}

final class DeleteProfilePictureState extends StartScreenState {}

final class ErrorCreateDataBaseState extends StartScreenState {
  final String?errMessage;
  ErrorCreateDataBaseState({this.errMessage});
}

final class FailureJoinInAppState extends StartScreenState {
  final String?errMessage;
  FailureJoinInAppState({this.errMessage});
}
final class SuccessJoinInAppState extends StartScreenState {}
