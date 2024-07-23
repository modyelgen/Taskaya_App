import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:sqflite/sqflite.dart';
import 'package:taskaya/core/utilites/cache_helper/file_caching_helper.dart';
import 'package:taskaya/core/utilites/constants/parameters.dart';
part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  int bottomNavCurrIndex=0;
  bool isLoading=false;
  String name='';
  String profilePicPath='null';
  HomeBloc() : super(HomeInitialState()) {
    on<HomeEvent>((event, emit) async{
      if(event is LoadCustomDataEvent){
        isLoading=true;
        try{
         await loadPersonalInfo();
         isLoading=false;
         emit(LoadCustomDataSuccess());
        }
            catch(e){
              isLoading=false;
          emit(LoadCustomDataFailed(errMessage: e.toString()));
            }
      }
      else if(event is ChangeBottomNavIconEvent) {
        bottomNavCurrIndex=event.currIndex;
        emit(ChangeBottomIconState());
      }

    });
  }
  Future<void> loadPersonalInfo()async{
    await openDatabase(personalInfoDb).then((value) {
      FileCacheHelper().getData(database: value, tableName: "data").then((value) {
        profilePicPath=value.first['profileImage'];
        name=value.first['name'];
      });
    });
  }
}
