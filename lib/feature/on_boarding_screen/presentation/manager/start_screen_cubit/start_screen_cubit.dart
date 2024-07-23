import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:taskaya/core/utilites/cache_helper/file_caching_helper.dart';
import 'package:taskaya/core/utilites/cache_helper/shared_pref.dart';
import 'package:taskaya/core/utilites/constants/parameters.dart';
part 'start_screen_state.dart';

class StartScreenCubit extends Cubit<StartScreenState> {
  StartScreenCubit() : super(StartScreenInitial());
  ImagePicker picker=ImagePicker();
  String? imageProfilePath;
  XFile?imageFile;
  late Database personalInfo;
  String cachedProfile="null";
  TextEditingController nameController=TextEditingController();

  void pickImage({required ImageSource imageSource}){
    picker.pickImage(source: imageSource).then((value) {
      if(value!=null){
        imageFile=value;
        imageProfilePath=value.path;
      }
      emit(ChangeProfilePictureState());
    });
  }

  void deletePickedImage(){
    if(imageProfilePath!=null){
      imageFile=null;
      imageProfilePath=null;
      emit(DeleteProfilePictureState());
    }
  }

  void initDataBaseForPersonalInfo() async {
    try{
      if(! await FileCacheHelper().checkOfExistOfDb(path: personalInfoDb)){
        await openDatabase(personalInfoDb,
            version: 1,
            onCreate: (database,version){
              database.execute("CREATE TABLE data (name TEXT, profileImage Text)");
            }).then((value) {
              personalInfo=value;
            }).then((value) async{
              await skipInfo();
            });

      }
    }
    catch(e){
      emit(ErrorCreateDataBaseState(errMessage: e.toString()));
    }
  }

  Future<void> prepareProfileFile()async{
    if(imageFile!=null){
      List<int>bytes=await imageFile!.readAsBytes();
      cachedProfile=await FileCacheHelper().saveFile("profilePicture", bytes);
    }
  }

  void joinInApp()async{
    await prepareProfileFile();
    try{
      await personalInfo.rawUpdate(
          'UPDATE data SET name = ?, profileImage = ? WHERE name = ?',
          [(nameController.text.isEmpty?" DefaultName":nameController.text), cachedProfile, 'DefaultName']);
      emit(SuccessJoinInAppState());
    }
    catch(e){
      emit(FailureJoinInAppState(errMessage: e.toString()));
    }


  }
  Future<void> skipInfo()async{
    try{
      await personalInfo.transaction((txn) async {
         await txn.rawInsert(
            'INSERT INTO data(name, profileImage) VALUES("DefaultName", "$cachedProfile")');
      });
      await SetAppState.skipStartScreen(skip: true);
    }
    catch(e){
      emit(FailureJoinInAppState(errMessage: e.toString()));
    }
  }
}
