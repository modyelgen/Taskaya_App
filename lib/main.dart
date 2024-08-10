import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:taskaya/bloc_observer.dart';
import 'package:taskaya/core/utilites/cache_helper/shared_pref.dart';
import 'package:taskaya/core/utilites/functions/notification_handler/notification.dart';
import 'package:taskaya/core/utilites/widgets/custom_material_widget.dart';
import 'package:taskaya/feature/settings/presentation/manager/settings_bloc.dart';

void main()async{
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  Bloc.observer=SimpleBlocObserver();
  await SetAppState.setShared();
  await AwesomeNotifications().getInitialNotificationAction(
      removeFromActionEvents: false
  );
  await CustomNotificationHandler.initNotification();
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



