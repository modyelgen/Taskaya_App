import 'package:flutter/material.dart';
import 'package:taskaya/core/utilites/functions/icon_to_string.dart';

class TaskModel{
  String taskName;
  String? taskDescription;
  int?priority;
  TaskTimeModel?taskTime;
  CategoryModel?taskCategory;
  TaskModel({required this.taskName,this.taskTime,this.priority,this.taskCategory,this.taskDescription});
}
class TaskTimeModel{
  String?dayDate;
  String?dayHourMinute;
  TaskTimeModel({this.dayDate,this.dayHourMinute});
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
