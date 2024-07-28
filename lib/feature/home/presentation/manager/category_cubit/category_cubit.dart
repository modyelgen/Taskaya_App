import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:taskaya/feature/home/data/models/task_model.dart';

part 'category_state.dart';

class CategoryCubit extends Cubit<CategoryState> {
  CategoryCubit() : super(CategoryInitialState());
  CategoryModel categoryModel=CategoryModel();
  Color?pickedColor;
  TextEditingController categoryController=TextEditingController();
  void onColorChange(){
    categoryModel.color=pickedColor;
    emit(CategoryChangeColorState());
  }
  void onChangeIcon({required IconData icon}){
    categoryModel.icon=icon;
    emit(CategoryChangeIconState());
  }

  void onChangeName(){
    categoryModel.name=categoryController.text;
    emit(CategoryChangeNameState());
  }
  bool returnModel(){
    if(categoryModel.color!=null&&categoryModel.name!=null&&categoryModel.icon!=null){
      return true;
    }
    return false;
  }
}
