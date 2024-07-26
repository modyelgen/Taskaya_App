import 'package:flutter/widgets.dart';

class TaskModel{
  String taskName;
  String? taskDescription;
  int?priority;
  TaskTime?taskTime;
  Category?taskCategory;
  TaskModel({required this.taskName,this.taskTime,this.priority,this.taskCategory,this.taskDescription});
}
class TaskTime{
  String?dayDate;
  String?dayHourMinute;
  TaskTime({this.dayDate,this.dayHourMinute});
}
class Category{
  Color?color;
  Icon?icon;
  Category({this.icon,this.color});
}
