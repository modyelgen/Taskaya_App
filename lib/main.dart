import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:taskaya/bloc_observer.dart';
import 'package:taskaya/core/utilites/app_theme/mode_theme.dart';
import 'package:taskaya/core/utilites/cache_helper/shared_pref.dart';
import 'package:taskaya/core/utilites/custom_localization/custom_app_localization.dart';
import 'package:taskaya/core/utilites/navigation/routers.dart';
import 'package:taskaya/feature/home/presentation/view/home_view.dart';
import 'package:taskaya/feature/on_boarding_screen/presentation/view/on_boarding_view.dart';
import 'package:taskaya/feature/on_boarding_screen/presentation/view/widgets/start_screen.dart';
import 'package:taskaya/feature/settings/presentation/manager/settings_bloc.dart';

void main()async{
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  Bloc.observer=SimpleBlocObserver();
  await SetAppState.setShared();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context)=>SettingsBloc()..add(InitialEvent()),
      child:  BlocBuilder<SettingsBloc,SettingsState>(
          builder: (context,state){
            var bloc=BlocProvider.of<SettingsBloc>(context);
            return CustomMaterialApp(bloc: bloc);
      })
    );
  }
}

class CustomMaterialApp extends StatelessWidget {
  const CustomMaterialApp({
    super.key,
    required this.bloc,
  });

  final SettingsBloc bloc;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      supportedLocales: const [
        Locale('en'),
        Locale('ar'),
      ],
      localizationsDelegates:const[
        CustomAppLocalization.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
          ],
      locale: bloc.local,
      localeResolutionCallback: (deviceLocal,supportedLocals){
        for(var item in supportedLocals){
          if(deviceLocal!=null&&deviceLocal.languageCode==item.languageCode){
            return deviceLocal;
          }
        }
        return supportedLocals.first;
      },
      debugShowCheckedModeBanner: false,
      theme: bloc.appTheme,
      themeMode: bloc.appMode,
      darkTheme: darkTheme,
      home:getHomeWidget(OnBoardingArgument(toggleMode: (){
        bloc.add(ToggleModeEvent());
      }, toggleLang: (){
        bloc.add(ChangeLanguageEvent());
      })),
    );
  }
}
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
