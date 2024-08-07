part of 'focus_bloc.dart';

@immutable
sealed class FocusEvent {}

class InitialFocusEvent extends FocusEvent {}

class ChangeDayUsageEvent extends FocusEvent {
  final int index;
  ChangeDayUsageEvent({required this.index});
}

class DenyAllowAppUsageEvent extends FocusEvent {}
