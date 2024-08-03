import 'package:flutter/widgets.dart';
import 'package:taskaya/core/utilites/navigation/routers.dart';
import 'package:taskaya/feature/home/presentation/view/home_view.dart';
import 'package:taskaya/feature/on_boarding_screen/presentation/view/on_boarding_view.dart';
import 'package:taskaya/feature/on_boarding_screen/presentation/view/widgets/start_screen.dart';

Widget getHomeWidget(OnBoardingArgument args){
  switch(checkIndex()){
    case FirstScreenEnum.onBoarding:
      return OnBoardingView(toggleMode: args.toggleMode, toggleLang:args.toggleLang);
    case FirstScreenEnum.startScreen:
      return const StartScreenView();
    case FirstScreenEnum.home:
      return const HomeView();
  }
}