import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sqflite/sqflite.dart';
import 'package:taskaya/core/utilites/app_theme/mode_theme.dart';
import 'package:taskaya/core/utilites/cache_helper/file_caching_helper.dart';
import 'package:taskaya/core/utilites/cache_helper/shared_pref.dart';
import 'package:taskaya/core/utilites/constants/parameters.dart';

import '../../../../core/utilites/functions/notification_handler/notification.dart';

part 'settings_event.dart';
part 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  ThemeData appTheme = SetAppState.prefs!.getBool('mood')?? true ? darkTheme : lightTheme ;
  bool enableNotification=false;
  ThemeMode appMode =SetAppState.prefs!.getBool('mood')?? true ? ThemeMode.dark :ThemeMode.light;
  Locale local= SetAppState.prefs!.getString('local')=="ar"?const Locale('ar') : const Locale('en');
  XFile?updatedProfile;
  TextEditingController nameController=TextEditingController();

  SettingsBloc() : super(SettingsInitialState()) {
    on<SettingsEvent>((event, emit)async{
      switch(event){
        case InitialEvent():
          await initInApp();
          break;
        case ToggleModeEvent():
          await changeMood(emit);
          break;
        case ChangeLanguageEvent():
         await changeLanguage(emit);
         break;
        case ChangeNotificationEvent():
          await changeNotification(emit);
          break;
        case DeleteCurrentImageEvent():
         await deleteProfilePic(name: event.name, emit: emit);
          break;
        case ChangeCurrentImageEvent():
         await updateProfilePic(name: event.nameAsKey, emit: emit);
          break;
        case ChangeCurrentNameEvent():
         await updateName(name: event.name, emit: emit);
          break;
        case OptionPickImageEvent():
          await pickImageFromCameraOrGallery(source: event.source,name: event.name);
        break;
      }
    });
  }

  Future<void> initInApp() async {
    FlutterNativeSplash.remove();
    enableNotification=await CustomNotificationHandler().checkPermissionOfChannel()>0?true:false;
    await CustomNotificationHandler.setListenerToNotification();
  }

  Future<void> changeMood(Emitter<SettingsState>emit)async{
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

  Future<void> changeLanguage(Emitter<SettingsState>emit)async{
    if(local.languageCode=="en"){
      local=const Locale("ar");

      await SetAppState.prefs?.setString("local", local.languageCode);
    }
    else{
      local=const Locale("en");
      await SetAppState.prefs?.setString("local", local.languageCode);

    }
    emit(ToggleToDifferentLanguageState());
  }



  Future<void> changeNotification(Emitter<SettingsState>emit)async{
    await CustomNotificationHandler().requestPermission().then((v)async{
    enableNotification= await CustomNotificationHandler().checkPermissionOfChannel()>0?true:false;
    });
    emit(ChangeNotificationState());
  }

  Future<void> updateProfilePic({required String name,required Emitter<SettingsState>emit})async{
    Database database=await openDatabase(personalInfoDb);
    if(updatedProfile!=null){
      await FileCacheHelper().deleteFile("profilePicture");
      List<int>bytes=await updatedProfile!.readAsBytes();
      await FileCacheHelper().saveFile("profilePicture", bytes).then((value) {
        try{
          database.rawUpdate("UPDATE data SET profileImage = ? WHERE name = ?",
              [value, name]);
          emit(ChangeProfilePictureSuccessState());
        }
        catch(e){
          log(e.toString());
          emit(ChangeProfilePictureErrorState());
        }

      });
    }

  }

  Future<void>  deleteProfilePic({required String name,required Emitter<SettingsState>emit})async{
    Database database=await openDatabase(personalInfoDb);
    await FileCacheHelper().deleteFile("profilePicture");
    database.rawUpdate("UPDATE data SET profileImage = ? WHERE name = ?",
        ["null", name]);
    emit(ChangeProfilePictureSuccessState());
  }

  Future<void>  updateName({required String name,required Emitter<SettingsState>emit})async{
    Database database=await openDatabase(personalInfoDb);
    await database.rawUpdate("UPDATE data SET name = ? WHERE name = ?",
        [nameController.text, name]);
    emit(ChangeNameSuccessState());
  }

  Future<void>  pickImageFromCameraOrGallery({required ImageSource source,required String name})async{
    await ImagePicker().pickImage(source: source).then((value) {
      if(value!=null){
        updatedProfile=value;
        add(ChangeCurrentImageEvent(nameAsKey: name));
      }
    });
  }
}
