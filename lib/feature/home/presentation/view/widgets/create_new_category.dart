import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconpicker/flutter_iconpicker.dart';
import 'package:taskaya/core/utilites/app_theme/colors.dart';
import 'package:taskaya/core/utilites/app_theme/text_style.dart';
import 'package:taskaya/core/utilites/widgets/custom_big_button.dart';
import 'package:taskaya/core/utilites/widgets/custom_text_form_field.dart';
import 'package:taskaya/feature/home/presentation/manager/category_cubit/category_cubit.dart';
import 'package:taskaya/feature/home/presentation/view/widgets/task_item_widget/category_item.dart';
import 'package:taskaya/feature/home/presentation/view/widgets/pick_custom_color.dart';

class CreateNewCategoryScreen extends StatelessWidget {
  const CreateNewCategoryScreen({super.key, required this.width, required this.height,required this.colorList});
  final double width;
  final double height;
  final List<Color>colorList;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context)=>CategoryCubit(colorList: colorList),
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
                        },label: "Choose icon from library",labelStyle: CustomTextStyle.fontNormal14.copyWith(color: Colors.white),borderRadius: 6,color: bottomNavBarColor,altWidth: width*0.5,),
                        SizedBox(height: height*0.035,),
                        PickCustomColor(height: height, width: width, cubit: cubit),
                        SizedBox(height: height*0.08,),
                        Center(child: CategoryItem(height: height, width: width,model: cubit.categoryModel,)),
                        const Spacer(),
                        SizedBox(
                          height: height*0.06,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              TextButton(onPressed: (){
                                Navigator.pop(context);
                              }, child: Text("Cancel",style: CustomTextStyle.fontBold18.copyWith(color: buttonColor),)),
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
                        ),

                      ],
                    ),
                  )),
            );
          }),
    );
  }
}

