import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:taskaya/core/utilites/app_theme/colors.dart';
import 'package:taskaya/core/utilites/constants/parameters.dart';
import 'package:taskaya/core/utilites/functions/notification_handler/notification_listener.dart';

class NotificationHandler{

  Future<void>initNotification()async{
    await AwesomeNotifications().initialize(
      // set the icon to null if you want to use the default app icon
        null,
        [
          NotificationChannel(
              channelGroupKey: 'basic_channel_group',
              channelKey: notificationReminder,
              channelName: 'reminder Notification',
              channelDescription: 'remind user with task to do',
              defaultColor: buttonColor,
              ledColor: bottomNavBarColor
          ),
        ],
        // Channel groups are only visual and are not required
        channelGroups: [
          NotificationChannelGroup(
              channelGroupKey: 'basic_channel_group',
              channelGroupName: 'Basic group')
        ],
        debug: true
    );
  }
  Future<void> setListenerToNotification()async{
    await AwesomeNotifications().setListeners(
      onActionReceivedMethod: (ReceivedAction receivedAction)async{
       await NotificationController.onActionReceivedMethod(receivedAction);

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
    return await AwesomeNotifications().isNotificationAllowed();
  }
  Future<void>createNewNotification({required String title,String? body,required DateTime notifyDate,required int id})async{

    if(notifyDate.isAfter(DateTime.now())){
    await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: id,
        category: NotificationCategory.Reminder,
        channelKey: notificationReminder,
        actionType: ActionType.Default,
        title: title,
        body: body??"",
      ),
      schedule:NotificationCalendar.fromDate(date: notifyDate.toLocal()),
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
      await AwesomeNotifications().cancelSchedule(id);
    }
  }

  Future<bool>checkExistOfId({required int id})async{
    bool checkExist=false;
    await AwesomeNotifications().listScheduledNotifications().then((value){
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
}