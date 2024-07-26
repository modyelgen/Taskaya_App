part of 'settings_bloc.dart';

@immutable
sealed class SettingsEvent {}

final class InitialEvent extends SettingsEvent {}

final class ToggleModeEvent extends SettingsEvent {}

final class ChangeLanguageEvent extends SettingsEvent {}

final class ChangeNotificationEvent extends SettingsEvent {
  final bool notify;
  ChangeNotificationEvent({required this.notify});
}

final class DeleteCurrentImageEvent extends SettingsEvent {
  final String name;
  DeleteCurrentImageEvent({required this.name});
}

final class ChangeCurrentImageEvent extends SettingsEvent {
  final String nameAsKey;
  ChangeCurrentImageEvent({required this.nameAsKey});
}

final class ChangeCurrentNameEvent extends SettingsEvent {
  final String name;
  ChangeCurrentNameEvent({required this.name});
}

final class OptionPickImageEvent extends SettingsEvent {
  final ImageSource source;
  final String name;
  OptionPickImageEvent({required this.source,required this.name});
}
