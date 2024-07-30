import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskaya/core/utilites/app_theme/colors.dart';
import 'package:taskaya/core/utilites/app_theme/text_style.dart';
import 'package:taskaya/core/utilites/widgets/custom_big_button.dart';
import 'package:taskaya/feature/home/presentation/manager/home_bloc.dart';
import 'package:taskaya/feature/home/presentation/view/widgets/task_item_widget/category_item.dart';
import 'package:taskaya/feature/home/presentation/view/widgets/create_new_category.dart';

class TaskCategory extends StatelessWidget {
  const TaskCategory({super.key,required this.height,required this.width,required this.bloc});
  final double width;
  final double height;
  final HomeBloc bloc;
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Material(
        color: bottomNavBarColor,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: height*0.015,horizontal: width*0.05),
          width: width*0.9,
          height: height*0.5,
          decoration: BoxDecoration(
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
                          ...List.generate(bloc.categoryList.length, (index)=>GestureDetector(
                            onTap: (){
                              bloc.add(ChangeCurrCategoryIndexEvent(index: index,pick: false));
                            },
                            child: Column(
                              children: [
                                CategoryItem(height: height, width: width,model: bloc.categoryList[index],),
                                if(index==bloc.currCategory)SizedBox(width: width*0.1,child: Divider(color: checkColor,)),
                              ],
                            ),
                          )),
                          GestureDetector(
                              onTap: ()async{
                                await Navigator.push(context, MaterialPageRoute(builder: (context)=>CreateNewCategoryScreen(width: width, height: height,colorList: bloc.getOldColor(),))).then((value){
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
              CustomBigButton(altWidth: width*0.8,color: buttonColor,label: "Choose Category",borderRadius: 4,labelStyle: CustomTextStyle.fontBoldWhite16,onTap: (){
                bloc.currCategory!=null?
                bloc.add(ChangeCurrCategoryIndexEvent(index: bloc.currCategory!,pick: true))
                    :null;
                Navigator.pop(context,bloc.categoryList[bloc.currCategory!]);
              },)
            ],
          ),
        ),
      ),
    );
  }
}

