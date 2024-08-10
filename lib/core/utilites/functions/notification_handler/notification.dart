import 'dart:developer';
import 'dart:isolate';
import 'dart:ui';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:taskaya/core/utilites/app_theme/colors.dart';
import 'package:taskaya/core/utilites/constants/parameters.dart';
import 'package:taskaya/core/utilites/functions/notification_handler/notification_action.dart';
import 'package:taskaya/core/utilites/functions/notification_handler/notification_listener.dart';

class CustomNotificationHandler{
AwesomeNotifications awesomeNotifications=AwesomeNotifications();
static bool initialized=false;
static ReceivePort? receivePort;
static Future<void> initializeIsolateReceivePort() async {
  receivePort = ReceivePort('Notification action port in main isolate');
  receivePort!.listen((serializedData)async {
    final receivedAction = ReceivedAction().fromMap(serializedData);
    await onActionReceivedMethodImpl(receivedAction);
  });

  // This initialization only happens on main isolate
  IsolateNameServer.registerPortWithName(
      receivePort!.sendPort,
      'notification_action_port');
}
 static Future<void>initNotification()async{
    await initializeIsolateReceivePort();
    await AwesomeNotifications().initialize(
      // set the icon to null if you want to use the default app icon
        null,
        [
          NotificationChannel(

            channelGroupKey: 'basic_channel_group',
            channelKey: notificationReminder,
            channelName: 'Reminder Notification',
            channelDescription: 'remind user with task to do',
            defaultColor: buttonColor,
            ledColor: bottomNavBarColor,
            importance: NotificationImportance.Max,
          ),
        ],
        debug: true
    );
  }
  static Future<void> setListenerToNotification()async{
    await AwesomeNotifications().setListeners(
      onActionReceivedMethod: (ReceivedAction receivedAction)async{
       await onActionReceivedMethod(receivedAction);

      },
      onNotificationCreatedMethod: (ReceivedNotification receivedNotification)async{
       await NotificationController.onNotificationCreatedMethod(receivedNotification);
      },
      onNotificationDisplayedMethod: (ReceivedNotification receivedNotification)async{
       await NotificationController.onNotificationDisplayedMethod(receivedNotification);
      },
      onDismissActionReceivedMethod: (ReceivedAction receivedAction)async{
        await NotificationController.onDismissActionReceivedMethod(receivedAction);
      },
    );
  }
  Future<bool>checkAllowingNotify()async{
    return await awesomeNotifications.isNotificationAllowed();
  }
  Future<int>checkPermissionOfChannel()async{
    List<NotificationPermission>list=await awesomeNotifications.checkPermissionList(channelKey: notificationReminder);
    return list.length;
  }
  Future<void>createNewNotification({required String title,String? body,required DateTime notifyDate,required int id})async{

    if(notifyDate.isAfter(DateTime.now())){
    await awesomeNotifications.createNotification(
      content: NotificationContent(
        id: id,
        category: NotificationCategory.Reminder,
        channelKey: notificationReminder,
        title: title,
        body: body??"",
      ),
      schedule:NotificationCalendar.fromDate(date: notifyDate.toLocal()),
      actionButtons: [
        NotificationActionButton(key: "Mark_done", label: "Mark As Done",actionType: ActionType.Default, ),
        NotificationActionButton(key: "snooze", label: "Snooze",requireInputText: true,actionType: ActionType.Default,),
        NotificationActionButton(key: "delete", label: "Delete"),
      ]
    );
  }
  }

  Future<void>updateCurrentNotification({required String title,String? body,required DateTime notifyDate,required int id})async{

    if(await checkExistOfId(id: id)){
      await deleteCurrentNotification(id: id).then((value)async{
        if(notifyDate.isAfter(DateTime.now())){
          await createNewNotification(title: title, notifyDate: notifyDate, id: id);
        }
      });
    }
    else{
      if(notifyDate.isAfter(DateTime.now())){
        await createNewNotification(title: title, notifyDate: notifyDate, id: id);
      }
    }
  }

  Future<void>deleteCurrentNotification({required int id})async{
    if(await checkExistOfId(id: id)){
      await awesomeNotifications.cancelSchedule(id);
    }
  }

  Future<bool>checkExistOfId({required int id})async{
    bool checkExist=false;
    await awesomeNotifications.listScheduledNotifications().then((value){
      checkExist=value.any((model){
        if(model.content?.id==id){
          return true;
        }
        else{
          return false;
        }
      });
    });
    return checkExist;
  }

  Future<bool>requestPermission()async{
    return await awesomeNotifications.requestPermissionToSendNotifications(
      channelKey: notificationReminder,
    );
  }

@pragma("vm:entry-point")
static Future<void> onActionReceivedMethod(
    ReceivedAction receivedAction) async {
  if (receivePort != null) {

    await onActionReceivedMethodImpl(receivedAction);
  } else {
    log(
        'onActionReceivedMethod was called inside a parallel dart isolate, where receivePort was never initialized.');
    SendPort? sendPort = IsolateNameServer
        .lookupPortByName('notification_action_port');

    if (sendPort != null) {
      log('Redirecting the execution to main isolate process in listening...');
      dynamic serializedData = receivedAction.toMap();
      sendPort.send(serializedData);
    }
  }
}
static Future<void> onActionReceivedMethodImpl(
    ReceivedAction receivedAction) async {
  var message = 'Action ${receivedAction.actionType?.name} received on ${
      receivedAction.actionLifeCycle?.name}';
  log(message);

  // Always ensure that all plugins was initialized
  WidgetsFlutterBinding.ensureInitialized();

  // bool isSilentAction =
  //     receivedAction.actionType == ActionType.SilentAction ||
  //         receivedAction.actionType == ActionType.SilentBackgroundAction;

  // SilentBackgroundAction runs on background thread and cannot show
  // UI/visual elements
  switch (receivedAction.buttonKeyPressed) {
    case 'Mark_done':
      log("i hope so");
      await updateTaskAtDb(received: receivedAction);
      break;

    case 'snooze':
      log("data");
      //await  CustomNotificationHandler().updateCurrentNotification(title: receivedAction.title??"", notifyDate: DateTime.now().copyWith(minute: DateTime.now().minute+int.tryParse(receivedAction.buttonKeyInput)!.toInt()), id: receivedAction.id??0);
      break;

    case 'delete':
      await deleteTaskAtDb(received: receivedAction);
      break;

  }

  // switch (receivedAction.buttonKeyPressed) {
  //   case 'Mark_done':
  //     await updateTaskAtDb(received: receivedAction);
  //     break;
  //
  //   case 'snooze':
  //   await  CustomNotificationHandler().updateCurrentNotification(title: receivedAction.title??"", notifyDate: DateTime.now().copyWith(minute: DateTime.now().minute+int.tryParse(receivedAction.buttonKeyInput)!.toInt()), id: receivedAction.id??0);
  //     break;
  //
  //   case 'delete':
  //     await deleteTaskAtDb(received: receivedAction);
  //     break;
  //
  // }
}
}
