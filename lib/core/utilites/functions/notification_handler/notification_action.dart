import 'dart:developer';
import 'dart:async';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:sqflite/sqflite.dart';
import 'package:taskaya/core/utilites/constants/parameters.dart';
Future<void> updateTaskAtDb({required ReceivedAction received})async{
  Database databaseHandle=await openDatabase(tasksListDb,version: 1);
  await databaseHandle.update("tasks", {"completed":1},
    where: 'taskID = ?',
    whereArgs: [received.id],
  ).then((value){

  },onError: (e)=>log(e.toString()));
  log("Updated Task");
  sendMessage("Update Task From Notification");
}
Future<void> deleteTaskAtDb({required ReceivedAction received})async{
  Database databaseHandle=await openDatabase(tasksListDb,version: 1);
  await databaseHandle.delete(
    "tasks",
    where: 'taskID = ?',
    whereArgs: [received.id],);
  log("deleted Task");
  sendMessage("Delete Task From Notification");
}




// Stream to listen to messages
// Stream<String> get messageStream => _messageStreamController.stream;

// Function to add messages
void sendMessage(String message) {
  final StreamController<String> messageStreamController = StreamController<String>.broadcast();
  messageStreamController.add(message);
}