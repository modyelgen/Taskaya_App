
import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:taskaya/core/utilites/cache_helper/file_caching_helper.dart';
import 'package:taskaya/core/utilites/constants/parameters.dart';
import 'package:taskaya/core/utilites/functions/notification_handler/notification.dart';
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
  final StreamController<String> messageStreamController = StreamController<String>.broadcast();
  String querySearch='';
  bool showMission=true;
  bool showComplete=true;
  late Database taskDb;
  String profilePicPath='null';
  List<CategoryModel>categoryList=[];
  TextEditingController taskController=TextEditingController();
  TextEditingController describeController=TextEditingController();
  int? currFlag;
  int? currCategory;
  DateTime?taskTime;
  List<TaskModel>taskList=[];
  List<TaskModel>filteredList=[];
  HomeBloc() : super(HomeInitialState()){
    startMethod();
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
          await deleteTask(taskID: event.taskID, emit: emit);
          break;
        case SearchInTasksEvent():
          await searchInTask(emit: emit, query: event.query);
          break;

        case ChangeShowOfTaskEvent():
          await changeShowOfTasks(emit: emit, type: event.type);
          break;
        case UpdateTaskEvent():
          await updateTask(model: event.model, emit: emit);
          break;
        case RefreshTaskList():
          emit(RefreshTaskHomeState());
          break;
      }
    });

  }
  void startMethod()async{
    Timer.periodic(const Duration(minutes: 1), (t){
      add(RefreshTaskList());
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
                  'taskID INTEGER PRIMARY KEY, '
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
        taskID: id.hashCode,
        taskName: taskController.text,
        taskDescription: describeController.text,
        taskCategory: pickCategory?categoryList[currCategory??0]:null,
        priority: pickPriority?currFlag:null,
        taskTime: taskTime,
      ));
      await saveTaskIntoDb(model: taskList.last);
      filteredList=List.from(taskList);
      emit(SuccessAddNewTaskState());
      if(taskList.last.taskTime!=null){
        await putNotificationForTask(taskaya: taskList.last);
      }
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


  Future<void>moveTask({required int taskID,required bool toComplete,required Emitter<HomeState>emit})async{
    if(toComplete) {
      taskList.where((model)=>model.taskID==taskID).first.completed=1;
      await disableNotificationForTask(id: taskID);
    }
    else{
      taskList.where((model)=>model.taskID==taskID).first.completed=0;
      await updateNotificationForTask(taskaya: taskList.where((model)=>model.taskID==taskID).first);
    }
    emit(MoveTaskState(isComplete: toComplete));
    updateTaskAtDb(task: taskList.where((model)=>model.taskID==taskID).first);
  }

  Future<void>updateTask({required TaskModel model,required Emitter<HomeState>emit})async{
    int index=taskList.indexWhere((task)=>model.taskID==task.taskID);
    taskList[index]=model;
    filteredList=List.from(taskList);
    emit(UpdateTaskHomeState());
    updateTaskAtDb(task: model);
    if(model.taskTime!=null){
      await updateNotificationForTask(taskaya: model);
    }
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

  void changeDayTime({required DateTime dayTime,required TimeOfDay hourTime}){
    taskTime=dayTime.copyWith(hour:hourTime.hour,minute:hourTime.minute);
  }

  void cleanModelAfter(){
    taskController.clear();
    currFlag=null;
    pickPriority=false;
    pickCategory=false;
    currCategory=null;
    describeController.clear();
    taskTime=null;
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

  Future<void> deleteTask({required int taskID,required Emitter<HomeState>emit})async{
    await disableNotificationForTask(id: taskID);
    taskList.removeWhere((model)=>model.taskID==taskID);
    filteredList=List.from(taskList);
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

  Future<void>changeShowOfTasks({required Emitter<HomeState>emit,required TaskTypesShowing type})async{
    switch(type){
      case TaskTypesShowing.mission:
        showMission=!showMission;
        emit(ChangeShowOfTaskState());
        break;
      case TaskTypesShowing.complete:
        showComplete=!showComplete;
        emit(ChangeShowOfTaskState());
        break;
    }

  }
}
enum TaskTypesShowing {mission,complete}

Future<void>putNotificationForTask({required TaskModel taskaya})async{
  DateTime time= taskaya.taskTime!;
  CustomNotificationHandler handler=CustomNotificationHandler();
  if(await handler.checkAllowingNotify()){

    await handler.createNewNotification(title: taskaya.taskName, body: taskaya.taskDescription, notifyDate:time,id: taskaya.taskID);
  }

}

Future<void>updateNotificationForTask({required TaskModel taskaya})async{
  DateTime time= taskaya.taskTime!;
  await CustomNotificationHandler().updateCurrentNotification(title: taskaya.taskName, notifyDate: time, id: taskaya.taskID);
}

Future<void>disableNotificationForTask({required int id})async{
  await CustomNotificationHandler().deleteCurrentNotification(id: id);
}