import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:taskaya/core/utilites/functions/icon_to_string.dart';

class TaskModel{
  String taskName;
  String? taskDescription;
  int?priority;
  TaskTimeModel?taskTime;
  CategoryModel?taskCategory;
  int completed;
  String taskID;
  TaskModel({required this.taskName,required this.taskID,this.taskTime,this.priority,this.taskCategory,this.taskDescription,this.completed=0});
  Map<String, dynamic> toMap() {
    return {
      'taskName': taskName,
      'taskDescription': taskDescription,
      'priority': priority,
      'taskTime': jsonEncode(taskTime?.toMap()),
      'taskCategory':jsonEncode(taskCategory?.toJson()),
      'completed': completed,
      'taskID': taskID,
    };
  }
  factory TaskModel.transfer({required TaskModel model}){
    return TaskModel(
      taskName:model.taskName,
      taskID: model.taskID,
      taskDescription: model.taskDescription,
      taskCategory: model.taskCategory,
      taskTime: model.taskTime,
      completed: model.completed,
      priority: model.priority,
    );
  }

  factory TaskModel.fromMap(Map<dynamic, dynamic> map) {
    return TaskModel(
      taskName: map['taskName'],
      taskID: map['taskID'],
      taskDescription: map['taskDescription'],
      priority: map['priority'],
      taskTime: map['taskTime'] != "null" ? TaskTimeModel.fromMap(jsonDecode(map['taskTime'])) : null,
      taskCategory: map['taskCategory'] != "null" ? CategoryModel.fromJson(jsonDecode(map['taskCategory']))  : null,
      completed: map['completed'],
    );
  }

}
class TaskTimeModel{
  DateTime?dayDate;
  TimeOfDay?dayHourMinute;
  TaskTimeModel({this.dayDate,this.dayHourMinute});
  Map<String, dynamic> toMap() {
    return {
      'dayDate': dayDate?.toIso8601String(),
      'dayHourMinute': dayHourMinute != null ? '${dayHourMinute!.hour}:${dayHourMinute!.minute}' : null,
    };
  }

  factory TaskTimeModel.fromMap(Map<String, dynamic> map) {
    return TaskTimeModel(
      dayDate: map['dayDate'] != null ? DateTime.parse(map['dayDate']) : null,
      dayHourMinute: map['dayHourMinute'] != null
          ? TimeOfDay(
        hour: int.parse(map['dayHourMinute'].split(':')[0]),
        minute: int.parse(map['dayHourMinute'].split(':')[1]),
      )
          : null,
    );
  }
}
class CategoryModel{
  Color?color;
  IconData?icon;
  String?name;
  CategoryModel({this.icon,this.color,this.name});
  factory CategoryModel.fromJson(Map<dynamic,dynamic>json){
    return CategoryModel(
      name:json['categoryName'],
      icon: stringToIconData(iconString: json['categoryIcon']),
      color: Color(json['categoryColor']),
    );
  }
  factory CategoryModel.fromCategory(Map<dynamic,dynamic>json){
    return CategoryModel(
      name:json['categoryName'],
      icon: stringToIconData(iconString: json['categoryIcon']),
      color: Color(int.parse(json['categoryColor'])),
    );
  }
  Map<String,dynamic>toJson(){
    return {
      "categoryName":name,
      "categoryIcon":iconDataToString(iconData: icon??const Icon(Icons.error).icon!),
      "categoryColor":color?.value??4278234089,
    };
  }
}
