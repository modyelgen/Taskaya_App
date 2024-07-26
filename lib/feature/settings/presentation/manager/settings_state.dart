part of 'settings_bloc.dart';

@immutable
sealed class SettingsState {}

final class SettingsInitialState extends SettingsState {}

final class ToggleToDifferentModeState extends SettingsState {}

final class ToggleToDifferentLanguageState extends SettingsState {}

final class ChangeNotificationState extends SettingsState {}

final class ChangeProfilePictureSuccessState extends SettingsState {}

final class ChangeProfilePictureErrorState extends SettingsState {}

final class ChangeNameSuccessState extends SettingsState {}