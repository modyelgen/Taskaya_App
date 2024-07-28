import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_iconpicker/flutter_iconpicker.dart';
import 'package:taskaya/core/utilites/app_theme/colors.dart';
import 'package:taskaya/core/utilites/app_theme/text_style.dart';
import 'package:taskaya/core/utilites/functions/get_related_color.dart';
import 'package:taskaya/core/utilites/widgets/custom_big_button.dart';
import 'package:taskaya/core/utilites/widgets/custom_text_form_field.dart';
import 'package:taskaya/feature/home/data/models/task_model.dart';
import 'package:taskaya/feature/home/presentation/manager/category_cubit/category_cubit.dart';
import 'package:taskaya/feature/home/presentation/manager/home_bloc.dart';

class TaskCategory extends StatelessWidget {
  const TaskCategory({super.key,required this.height,required this.width,required this.bloc});
  final double width;
  final double height;
  final HomeBloc bloc;
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: height*0.015,horizontal: width*0.05),
        width: width*0.9,
        height: height*0.5,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: bottomNavBarColor,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("Choose Category",style: CustomTextStyle.fontBoldWhite16),
            SizedBox(
              width: width*0.75,
              child: Divider(
                thickness: 1,
                color: customBorderColor,
              ),
            ),
            SizedBox(height: height*0.015,),
            SizedBox(
              height: height*0.3,
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: BlocBuilder<HomeBloc,HomeState>(
                  bloc: bloc,
                  builder: (context,state){
                    return Wrap(
                      spacing: height*0.02,
                      runSpacing: width*0.05,
                      children: [
                        ...List.generate(bloc.categoryList.length, (index)=>CategoryItem(height: height, width: width,model: bloc.categoryList[index],)),
                        GestureDetector(
                            onTap: ()async{
                              await Navigator.push(context, MaterialPageRoute(builder: (context)=>CreateNewCategoryScreen(width: width, height: height))).then((value){
                                if(value!=null){
                                  bloc.add(CreateNewCategoryEvent(model: value));
                                }
                              });
                            },
                            child: CategoryItem(height: height, width: width))

                      ],
                    );
                  }
                ),
              ),
            ),
            SizedBox(height: height*0.05,),
            CustomBigButton(altWidth: width*0.8,color: buttonColor,label: "Choose Category",borderRadius: 4,labelStyle: CustomTextStyle.fontBoldWhite16,)
          ],
        ),
      ),
    );
  }
}
class CategoryItem extends StatelessWidget {
  const CategoryItem({super.key,required this.height,required this.width,this.model});
  final double width;
  final double height;
  final CategoryModel? model;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: width*0.175,
          height: height*0.075,
          decoration: BoxDecoration(
            color: model?.color??const Color(0xff80FFD1),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Icon(model?.icon??CupertinoIcons.add,color: getRelatedColor(model?.color??const Color(0xff80FFD1),),size: width*0.1,),
        ),
        SizedBox(height: height*0.01,),
        Text(model?.name??"Create New",style: CustomTextStyle.fontBoldWhite16.copyWith(decoration:TextDecoration.none,fontSize: 14),),
      ],
    );
  }
}

class CreateNewCategoryScreen extends StatelessWidget {
  const CreateNewCategoryScreen({super.key, required this.width, required this.height});
  final double width;
  final double height;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context)=>CategoryCubit(),
      child: BlocBuilder<CategoryCubit,CategoryState>(
          builder: (context,state){
            var cubit=BlocProvider.of<CategoryCubit>(context);
            return Scaffold(
              resizeToAvoidBottomInset: false,
              body: SafeArea(
                  child: Padding(
                    padding: EdgeInsetsDirectional.symmetric(horizontal: width*0.05,vertical: height*0.025),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Create New Category",style: CustomTextStyle.fontBold21,),
                        SizedBox(
                          height: height*0.05,
                        ),
                        Text("Category Name:",style: CustomTextStyle.fontNormal16,),
                        SizedBox(height: height*0.015,),
                        SizedBox(
                            height: height*0.075,
                            child: CustomTextFormField(borderWidth: 0.8,label: "Category Name",border: 4,controller: cubit.categoryController,onChanged: (value){
                              cubit.onChangeName();
                            },)),
                        SizedBox(height: height*0.035,),
                        Text("Category Icon:",style: CustomTextStyle.fontNormal16,),
                        SizedBox(height: height*0.015,),
                        CustomBigButton(onTap: ()async{
                          await showIconPicker(context).then((value){
                            if(value!=null){
                              cubit.onChangeIcon(icon: value);
                            }
                          });
                        },label: "Choose icon from library",labelStyle: CustomTextStyle.fontNormal14,borderRadius: 6,color: bottomNavBarColor,altWidth: width*0.5,),
                        SizedBox(height: height*0.035,),
                        Text("Category Color:",style: CustomTextStyle.fontNormal16,),
                        SizedBox(height: height*0.015,),
                        SingleChildScrollView(
                          padding: EdgeInsets.zero,
                          physics: const BouncingScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              ...List.generate(tempColor.length, (index)=>Padding(
                                padding: EdgeInsetsDirectional.only(end: width*0.025),
                                child: CircleAvatar(
                                    radius: 20,
                                    backgroundColor: tempColor[index]
                                ),
                              )),
                              CircleAvatar(
                                radius: 20,
                                child: IconButton(onPressed: (){
                                  showDialog(context: context, builder:(context)=>AlertDialog(
                                    title:const Text("Pick Color!"),
                                    content:ColorPicker(
                                        pickerColor: darkColor,
                                        onColorChanged: (value){
                                          cubit.pickedColor=value;
                                        }),
                                    actions: [
                                      TextButton(onPressed: (){
                                        Navigator.pop(context);
                                      }, child: Text("Cancel",style: CustomTextStyle.fontNormal16.copyWith(color: buttonColor),)),

                                      CustomBigButton(onTap: (){
                                        cubit.onColorChange();
                                        Navigator.pop(context);
                                      },label: "Pick",color: buttonColor,altWidth: width*0.2,borderRadius: 4,labelStyle: CustomTextStyle.fontNormal12.copyWith(color: Colors.white),)
                                    ],
                                  ));
                                },icon:Icon(Icons.colorize,color: buttonColor,),),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: height*0.1,),
                        Center(child: CategoryItem(height: height, width: width,model: cubit.categoryModel,)),
                        const Spacer(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TextButton(onPressed: null, child: Text("Cancel",style: CustomTextStyle.fontBold18.copyWith(color: buttonColor),)),
                            CustomBigButton(
                              onTap: (){
                                if(cubit.returnModel()){
                                  Navigator.pop(context,cubit.categoryModel);
                                }

                              },
                              color: buttonColor,
                              altWidth: width*0.5,
                              borderRadius: 4,
                              label: "Create Category",
                              labelStyle: CustomTextStyle.fontBoldWhite16,
                            ),
                          ],
                        ),

                      ],
                    ),
                  )),
            );
      }),
    );
  }
}
List<Color>tempColor=[
  const Color(0xffF2DFD7),
  const Color(0xffFEF9FF),
  const Color(0xffd4c1ec),
  const Color(0xff9f9fed),
  const Color(0xff736CED),
];

