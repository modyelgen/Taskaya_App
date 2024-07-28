import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:taskaya/core/utilites/cache_helper/file_caching_helper.dart';
import 'package:taskaya/core/utilites/constants/parameters.dart';
import 'package:taskaya/feature/home/data/models/task_model.dart';
part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  int bottomNavCurrIndex=0;
  bool isLoading=false;
  bool canPoop=false;
  String name='';
  OverlayEntry?overlayEntry;
  String profilePicPath='null';
  List<CategoryModel>categoryList=[];
  int currFlag=0;
  Icon? tempIcon;
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
          await changeCurrFlag(emit: emit,index: event.index);
          break;
        case AllowToPopEvent():
          await allowToPoop(allow: event.allow, emit: emit);
          break;
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
      isLoading=false;
      emit(LoadCustomDataSuccess());
    }
    catch(e){
      isLoading=false;
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
              categoryList.add(CategoryModel.fromJson(item));
            }
          }
        });
      });
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

  Future<void>changeCurrFlag({required int index,required Emitter<HomeState>emit})async{
   currFlag=index;
   emit(ChangeFlagIndexState());
  }

  Future<void>allowToPoop({required bool allow,required Emitter<HomeState>emit})async{
   canPoop=allow;
   emit(ChangeNavigationToPopState());
  }
}
