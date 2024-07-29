import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskaya/feature/home/data/models/task_model.dart';

part 'category_state.dart';

class CategoryCubit extends Cubit<CategoryState> {
  CategoryCubit({required this.colorList}) : super(CategoryInitialState());
  CategoryModel categoryModel=CategoryModel();
  List<Color>colorList;
  Color?pickedColor;
  int currColorIndex=0;
  TextEditingController categoryController=TextEditingController();
  void onColorChange({Color?color,int? index}){
    if(color!=null){
      categoryModel.color=color;
      currColorIndex=index??0;
      emit(CategoryChangeColorState());
    }
    else{
      if(pickedColor!=null){
        colorList.add(pickedColor!);
        currColorIndex=colorList.length-1;
        categoryModel.color=pickedColor;
        emit(CategoryChangeColorState());
      }

    }

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
