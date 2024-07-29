
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:taskaya/core/utilites/cache_helper/file_caching_helper.dart';
import 'package:taskaya/core/utilites/constants/parameters.dart';
import 'package:taskaya/feature/home/data/models/task_model.dart';
import 'package:uuid/uuid.dart';
part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  int bottomNavCurrIndex=0;
  bool isLoading=false;
  bool canPoop=false;
  bool pickCategory=false;
  bool pickPriority=false;
  String name='';
  String querySearch='';
  late Database taskDb;
  String profilePicPath='null';
  List<CategoryModel>categoryList=[];
  TextEditingController taskController=TextEditingController();
  TextEditingController describeController=TextEditingController();
  int? currFlag;
  int? currCategory;
  TaskTimeModel?taskTimeModel;
  List<TaskModel>taskList=[];
  List<TaskModel>filteredList=[];
  HomeBloc() : super(HomeInitialState()){
    on<HomeEvent>((event, emit) async{
      switch(event){
        case LoadCustomDataEvent():
         await loadPersonalInfo(emit);
         await loadCategoryList();
         break;
        case ChangeBottomNavIconEvent():
          await changeBottomNav(currIndex: event.currIndex, emit: emit);
          break;
        case CreateNewCategoryEvent():
          await createNewCategory(emit: emit, model: event.model);
          break;
        case ChangeCurrFlagIndexEvent():
          await changeCurrFlag(emit: emit,index: event.index,pick: event.pick);
          break;
        case AllowToPopEvent():
          await allowToPoop(allow: event.allow, emit: emit);
          break;
        case ChangeCurrCategoryIndexEvent():
          await changeCurrCategory(index: event.index, emit: emit,pick: event.pick);
          break;
        case CreateNewTaskEvent():
          await createNewTask(emit);
          break;
        case MoveTaskEvent():
          await moveTask(taskID: event.taskID, toComplete: event.toComplete, emit: emit);
          break;
        case LoadTaskEvent():
          await loadTaskList(emit: emit);
          break;
        case RemoveTaskEvent():
          await deleteTask(taskID: event.taskID, complete: event.isComplete, emit: emit);
          break;
        case SearchInTasksEvent():
          await searchInTask(emit: emit, query: event.query);
      }
    });
  }
  Future<void> loadPersonalInfo(Emitter<HomeState>emit)async{
    try{
      await openDatabase(personalInfoDb).then((value) {
        FileCacheHelper().getData(database: value, tableName: "data").then((value) {
          profilePicPath=value.first['profileImage'];
          name=value.first['name'];
        });
      });
      emit(LoadCustomDataSuccess());
    }
    catch(e){
      emit(LoadCustomDataFailed(errMessage: e.toString()));
    }
  }

  Future<void> changeBottomNav({required int currIndex,required Emitter<HomeState>emit})async{
    bottomNavCurrIndex=currIndex;
    emit(ChangeBottomIconState());
  }

  Future<void>createNewCategory({required Emitter<HomeState>emit,required CategoryModel model})async{
    categoryList.add(model);
    emit(AddNewCategoryState());
    await saveNewCategoryIntoDb(emit);
  }

  Future<void> loadCategoryList()async{
    if( ! await FileCacheHelper().checkOfExistOfDb(path: categoryListDb)){
      await openDatabase(categoryListDb,
          version: 1,
          onCreate: (database,version){
            database.execute("CREATE TABLE data (categoryIcon TEXT, categoryName Text,categoryColor Text)");
          });
    }
    else{
      await openDatabase(categoryListDb).then((value) {
        FileCacheHelper().getData(database: value, tableName: "data").then((value) {
          if(value.isNotEmpty){
            for(var item in value){
              categoryList.add(CategoryModel.fromCategory(item));
            }
          }
        });
      });
    }
  }

  Future<void> loadTaskList({required Emitter<HomeState>emit})async{
    if( ! await FileCacheHelper().checkOfExistOfDb(path: tasksListDb)){
      try{
        isLoading=true;
        emit(LoadingLoadTaskListState());
        await openDatabase(tasksListDb,
          version: 1,
          onCreate: (database,version){
            return database.execute(
              'CREATE TABLE tasks('
                  'taskID TEXT PRIMARY KEY, '
                  'taskName TEXT, '
                  'taskDescription TEXT, '
                  'priority INTEGER, '
                  'taskTime TEXT, ' // store JSON string
                  'taskCategory TEXT, ' // store JSON string
                  'completed INTEGER'
                  ')',
            );
          },).then((value){
            taskDb=value;
        });
        isLoading=false;
        emit(SuccessLoadTaskListState());
      }
      catch(e){
        isLoading=false;
        emit(FailureLoadTaskListState(errMessage: e.toString()));
      }

    }
    else{
      try{
        isLoading=true;
        emit(LoadingLoadTaskListState());
         await openDatabase(tasksListDb).then((value) {
           taskDb=value;
           FileCacheHelper().getData(database: value, tableName: "tasks").then((value) {
            if(value.isNotEmpty){
              for(var item in value){
                taskList.add(TaskModel.fromMap(item));
              }
              filteredList=List<TaskModel>.from(taskList);
            }
          });
        });
        isLoading=false;
        emit(SuccessLoadTaskListState());
      }
      catch(e){
        isLoading=false;
        emit(FailureLoadTaskListState(errMessage: e.toString()));
      }

    }
  }

  Future<void>saveNewCategoryIntoDb(Emitter<HomeState>emit)async{
    Database database=await openDatabase(categoryListDb);
    try{
      Map<String,dynamic>toJson=categoryList.last.toJson();
      await database.transaction((txn) async {
        await txn.rawInsert(
            'INSERT INTO data(categoryColor, categoryIcon,categoryName) VALUES("${toJson['categoryColor']}", "${toJson["categoryIcon"]}","${toJson["categoryName"]}")');
      });
      emit(LoadNewCategorySuccessState());
    }
    catch(e){
      emit(LoadNewCategoryFailureState(errMessage:e.toString()));
    }
  }

  Future<void>createNewTask(Emitter<HomeState>emit)async{
    if(taskController.text.isNotEmpty&&taskController.text.trim().isNotEmpty){
      var uuid = const Uuid();
      String id = uuid.v4();
      taskList.add(TaskModel(
        taskID: id,
        taskName: taskController.text,
        taskDescription: taskController.text,
        taskCategory: pickCategory?categoryList[currCategory??0]:null,
        priority: pickPriority?currFlag:null,
        taskTime: taskTimeModel==null?null:TaskTimeModel(dayDate:taskTimeModel?.dayDate,dayHourMinute:taskTimeModel?.dayHourMinute),
      ));
      await saveTaskIntoDb(model: taskList.last);
      emit(SuccessAddNewTaskState());
      cleanModelAfter();

    }
  }

  Future<void>changeCurrFlag({required int index,required Emitter<HomeState>emit,required bool pick})async{
    if(pick){
      currFlag=index;
      pickPriority=pick;
      emit(ChangeFlagIndexState());
    }
    else{
      currFlag=index;
      pickPriority=pick;
      emit(ChangeFlagIndexState());
    }
  }

  Future<void>changeCurrCategory({required int index,required bool pick,required Emitter<HomeState>emit})async{
    if(pick){
      currCategory=index;
      pickCategory=pick;
      emit(ChangeCategoryIndexState());
    }
    else{
      currCategory=index;
      emit(ChangeCategoryIndexState());
    }

  }

  Future<void>moveTask({required String taskID,required bool toComplete,required Emitter<HomeState>emit})async{
    if(toComplete){
      taskList.where((model)=>model.taskID==taskID).first.completed=1;
    }
    else{
      taskList.where((model)=>model.taskID==taskID).first.completed=0;
    }
    emit(MoveTaskState());
  }

  Future<void>allowToPoop({required bool allow,required Emitter<HomeState>emit})async{
   canPoop=allow;
   emit(ChangeNavigationToPopState());
  }

  List<Color>getOldColor(){
    List<Color>tempList=[];
    if(categoryList.isEmpty){
      return tempList;
    }
    else{
    for(var item in categoryList){
      tempList.add(item.color!);
    }
    return tempList;
    }

  }

  void changeDayTime({DateTime? dayTime,TimeOfDay?hourTime}){
    taskTimeModel=TaskTimeModel(dayDate: dayTime,dayHourMinute: hourTime);
  }

  void cleanModelAfter(){
    taskController.clear();
    currFlag=null;
    pickPriority=false;
    pickCategory=false;
    currCategory=null;
    describeController.clear();
    taskTimeModel=null;
  }

  Future<void> saveTaskIntoDb({required TaskModel model})async{
    try{
      await taskDb.insert(
        'tasks',
        model.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
    catch(e){
      log(e.toString());
    }
  }

  Future<void> deleteTask({required String taskID,required bool complete,required Emitter<HomeState>emit})async{
    taskList.removeWhere((model)=>model.taskID==taskID);
    emit(RemoveTaskState());
    await taskDb.delete(
      'tasks',
      where: 'taskID = ?',
      whereArgs: [taskID],
    );
  }

  Future<void> updateTaskAtDb({required TaskModel task})async{
    await taskDb.update(
      'tasks',
      task.toMap(),
      where: 'taskID = ?',
      whereArgs: [task.taskID],
    );
  }

  Future<void>searchInTask({required Emitter<HomeState>emit,required String query})async{
    if(query.isNotEmpty&&query.trim().isNotEmpty){
      querySearch=query;
      filteredList = filteredList.where((item) {
        return item.taskName.toLowerCase().contains(query.toLowerCase());
      }).toList();
    }
    else{
      querySearch='';
      filteredList=List.from(taskList);
    }
    emit(ChangeTaskAccordingToSearchState());
  }
}
