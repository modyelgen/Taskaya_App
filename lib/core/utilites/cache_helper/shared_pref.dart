
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taskaya/core/utilites/functions/notification_handler/notification.dart';
class SetAppState{

  static SharedPreferences? prefs;
  static Future<void>setShared()async{
    try{
      prefs=await SharedPreferences.getInstance();
    }
    catch (e){
      prefs=null;
    }

  }
  static Future<void> setCurrIndex({int index=0})async{

    await prefs?.setInt('currIndex', index);
  }
  static Future<void> setNotification({bool enable=true})async{
    enable=await CustomNotificationHandler().checkAllowingNotify();
    await prefs?.setBool('notify', enable);
  }

  static Future<void> skipStartScreen({bool skip=false})async{

    await prefs?.setBool('startScreen', skip);
  }

  static Future<void> localLang({String local="en"})async{

    await prefs?.setString('local', local);
  }

  static Future<void> appMood({bool dark=false})async{

    await prefs?.setBool('mood', dark);
  }

}
