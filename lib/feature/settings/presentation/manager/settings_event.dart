part of 'settings_bloc.dart';

@immutable
sealed class SettingsEvent {}

final class InitialEvent extends SettingsEvent {}

final class ToggleModeEvent extends SettingsEvent {}

final class ChangeLanguageEvent extends SettingsEvent {}
