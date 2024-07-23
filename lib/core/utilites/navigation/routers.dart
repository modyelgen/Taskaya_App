import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taskaya/core/utilites/cache_helper/shared_pref.dart';
import 'package:taskaya/feature/home/presentation/view/home_view.dart';
import 'package:taskaya/feature/on_boarding_screen/presentation/view/on_boarding_view.dart';
import 'package:taskaya/feature/on_boarding_screen/presentation/view/widgets/start_screen.dart';
class RouterApp {
  static const kOnBoardingView = '/OnBoardingView';
  static const kStartScreen = '/StartScreenView';
  static const kHomeView = '/HomeView';
  static GoRouter goRouter(OnBoardingArgument args){
    return GoRouter(routes: [
      GoRoute(
        path: '/',
        builder: (context, state) {
          switch(checkIndex()){
            case FirstScreenEnum.onBoarding:
              return OnBoardingView(toggleMode: args.toggleMode, toggleLang:args.toggleLang);
            case FirstScreenEnum.startScreen:
              return const StartScreenView();
            case FirstScreenEnum.home:
              return const HomeView();
          }
        },
      ),
      GoRoute(
        path: kStartScreen,
        builder: (context, state) {
          return const StartScreenView();
        },
      ),
      GoRoute(
        path: kHomeView,
        builder: (context, state) {
          return const HomeView();
        },
      ),
    ]);
  }

}

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