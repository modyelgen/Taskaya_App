part of 'on_boarding_bloc.dart';

@immutable
sealed class OnBoardingEvent {}

final class MoveForwardEvent extends OnBoardingEvent {}

final class MoveBackwardEvent extends OnBoardingEvent {}

final class TogglePageEvent extends OnBoardingEvent {
  final int index;
  TogglePageEvent({required this.index});
}
