
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:taskaya/core/utilites/app_theme/mode_theme.dart';

part 'settings_event.dart';
part 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  ThemeData appTheme = lightTheme;
  ThemeMode appMode = ThemeMode.light;
  Locale local=const Locale('en');
  SettingsBloc() : super(SettingsInitialState()) {
    on<SettingsEvent>((event, emit){
      if(event is InitialEvent){
         FlutterNativeSplash.remove();
      }
      else if(event is ToggleModeEvent){
        if(appTheme==lightTheme){
          appTheme=darkTheme;
          appMode=ThemeMode.dark;
          emit(ToggleToDifferentModeState());
        }
        else{
          appTheme=lightTheme;
          appMode=ThemeMode.light;
          emit(ToggleToDifferentModeState());
        }
      }
      else if (event is ChangeLanguageEvent){
        if(local.languageCode=="en"){
          local=const Locale("ar");
        }
        else{
          local=const Locale("en");
        }
        emit(ToggleToDifferentLanguageState());
      }
    });
  }
}
