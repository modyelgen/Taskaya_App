import 'package:shared_preferences/shared_preferences.dart';
import 'package:taskaya/core/utilites/cache_helper/shared_pref.dart';

class OnBoardingArgument {
  final void Function() toggleMode;
  final void Function() toggleLang;

  OnBoardingArgument({required this.toggleMode, required this.toggleLang});
}

FirstScreenEnum checkIndex(){
  SharedPreferences? prefs=SetAppState.prefs;
  if(prefs?.getInt("currIndex") ==0){
    return FirstScreenEnum.onBoarding;
  }
  else if(prefs?.getInt("currIndex") !=0&& prefs?.getBool("startScreen")==false){
    return FirstScreenEnum.startScreen;
  }
  else if(prefs?.getInt("currIndex") !=0&& prefs?.getBool("startScreen")==true){
    return FirstScreenEnum.home;
  }
  else{
    return FirstScreenEnum.onBoarding;
  }
}

enum FirstScreenEnum{onBoarding,startScreen,home}