
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:taskaya/core/utilites/app_theme/mode_theme.dart';
import 'package:taskaya/core/utilites/cache_helper/shared_pref.dart';

part 'settings_event.dart';
part 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  ThemeData appTheme = SetAppState.prefs!.getBool('mood')?? true ? darkTheme : lightTheme ;

  ThemeMode appMode =SetAppState.prefs!.getBool('mood')?? true ? ThemeMode.dark :ThemeMode.light;
  Locale local= SetAppState.prefs!.getString('local')=="ar"?const Locale('ar') : const Locale('en');
  SettingsBloc() : super(SettingsInitialState()) {
    on<SettingsEvent>((event, emit)async{
      if(event is InitialEvent){
         FlutterNativeSplash.remove();
      }
      else if(event is ToggleModeEvent){
        if(appTheme==lightTheme){
          appTheme=darkTheme;
          appMode=ThemeMode.dark;
          await SetAppState.prefs?.setBool("mood", true);
          emit(ToggleToDifferentModeState());
        }
        else{
          appTheme=lightTheme;
          appMode=ThemeMode.light;
          await SetAppState.prefs?.setBool("mood", false);
          emit(ToggleToDifferentModeState());
        }
      }
      else if (event is ChangeLanguageEvent){
        if(local.languageCode=="en"){
          local=const Locale("ar");
          await SetAppState.prefs?.setString("local", local.languageCode);
        }
        else{
          await SetAppState.prefs?.setString("local", local.languageCode);
          local=const Locale("en");
        }
        emit(ToggleToDifferentLanguageState());
      }
    });
  }
}
