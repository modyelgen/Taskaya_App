import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:taskaya/core/utilites/app_theme/colors.dart';
import 'package:taskaya/core/utilites/app_theme/text_style.dart';
import 'package:taskaya/core/utilites/functions/theme_function.dart';
import 'package:taskaya/core/utilites/widgets/custom_big_button.dart';
import 'package:taskaya/feature/home/presentation/manager/category_cubit/category_cubit.dart';
class PickCustomColor extends StatelessWidget {
  const PickCustomColor({
    super.key,
    required this.height,
    required this.width,
    required this.cubit,
  });

  final double height;
  final double width;
  final CategoryCubit cubit;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Category Color:",style: CustomTextStyle.fontNormal16,),
        SizedBox(height: height*0.015,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.zero,
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    ...List.generate(cubit.colorList.length, (index)=>GestureDetector(
                      onTap: (){
                        cubit.onColorChange(color: cubit.colorList[index],index: index);
                      },
                      child: Padding(
                        padding: EdgeInsetsDirectional.only(end: width*0.025),
                        child: CircleAvatar(
                          radius: 25,
                          backgroundColor: index==cubit.currColorIndex?const Color(0xff4FD75C):GetColor(context: context).getInverseColor(),
                          child: CircleAvatar(
                              radius: 20,
                              backgroundColor: cubit.colorList[index]
                          ),
                        ),
                      ),
                    )),
                  ],
                ),
              ),
            ),
            SizedBox(width: width*0.05,),
            CircleAvatar(
              backgroundColor: GetColor(context: context).getNormalColor(),
              radius: 25,
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
      ],
    );
  }
}