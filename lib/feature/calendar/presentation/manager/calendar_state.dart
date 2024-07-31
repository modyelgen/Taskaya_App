part of 'calendar_bloc.dart';

@immutable
sealed class CalendarState {}

final class CalendarInitialState extends CalendarState {}

final class UpdateCalendarDaysState extends CalendarState {}

final class UpdateCalendarMonthState extends CalendarState {}

final class ChangePickedDayState extends CalendarState {}

final class FilterListState extends CalendarState {}
