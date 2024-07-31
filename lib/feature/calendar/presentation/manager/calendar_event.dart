part of 'calendar_bloc.dart';

@immutable
sealed class CalendarEvent {}

final class InitialCalendarEvent extends CalendarEvent{}

final class ChangeDayPickerEvent extends CalendarEvent{
  final int index;
  ChangeDayPickerEvent({required this.index});
}

final class ChangeCurrMonthEvent extends CalendarEvent{
  final bool forward;
  ChangeCurrMonthEvent({required this.forward});
}
