import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:taskaya/core/utilites/app_theme/mode_theme.dart';
import 'package:taskaya/core/utilites/custom_localization/custom_app_localization.dart';
import 'package:taskaya/core/utilites/navigation/routers.dart';
import 'package:taskaya/core/utilites/widgets/get_start_screen.dart';
import 'package:taskaya/feature/settings/presentation/manager/settings_bloc.dart';

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
      localizationsDelegates:const
      [
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