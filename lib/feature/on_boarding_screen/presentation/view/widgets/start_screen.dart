import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:taskaya/core/utilites/app_theme/colors.dart';
import 'package:taskaya/core/utilites/app_theme/text_style.dart';
import 'package:taskaya/core/utilites/custom_localization/custom_app_localization.dart';
import 'package:taskaya/core/utilites/dimensions/responsive_layout.dart';
import 'package:taskaya/core/utilites/navigation/routers.dart';
import 'package:taskaya/core/utilites/widgets/custom_big_button.dart';
import 'package:taskaya/core/utilites/widgets/custom_text_form_field.dart';
import 'package:taskaya/feature/on_boarding_screen/presentation/manager/start_screen_cubit/start_screen_cubit.dart';
import 'package:taskaya/feature/on_boarding_screen/presentation/view/widgets/otpion_pick_image.dart';

class StartScreenView extends StatelessWidget {
  const StartScreenView({super.key});
  @override
  Widget build(BuildContext context) {
    final double width=BasicDimension.screenWidth(context);
    final double height=BasicDimension.screenHeight(context);
    return BlocProvider(
      create: (context)=>StartScreenCubit()..initDataBaseForPersonalInfo(),
      child:BlocConsumer<StartScreenCubit,StartScreenState>(
          listener: (context,state){

          },
          builder: (context,state){
            var cubit=BlocProvider.of<StartScreenCubit>(context);
            return Scaffold(
              body: SafeArea(
                child:SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      IconButton(onPressed: (){
                        Navigator.pop(context);
                      }, icon: const Icon(Icons.arrow_back_ios_new,),),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: width*0.05).copyWith(bottom: height*0.05),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(height: height*0.025,),
                            SizedBox(
                                width: width,
                                height: height*0.075,
                                child: Text("welcome_Message".tr(context),style: CustomTextStyle.fontBold32,textAlign: TextAlign.center,)),
                            SizedBox(height: height*0.05,),
                            GestureDetector(
                              onTap: (){
                                showModalBottomSheet(context: context, builder: (context){
                                  return OptionPickImage(width: width, height: height, cubit: cubit,);
                                });
                              },
                              child: CircleAvatar(
                                radius: width*0.2,
                                child: Center(
                                    child:cubit.imageProfilePath==null?Icon(CupertinoIcons.person_badge_plus_fill,size: width*0.25,):ClipRRect(
                                      borderRadius: BorderRadius.circular(width*0.21),
                                        child: Image.file(File(cubit.imageProfilePath!,),width: width*0.4,fit: BoxFit.fitWidth,))),
                              ),
                            ),
                            SizedBox(height: height*0.05,),
                            CustomTextFormField(label: "enter_Name".tr(context),filled: true,borderColor: purpleColor,maxLength: 18,controller: cubit.nameController,),
                            SizedBox(height: height*0.225,),
                            CustomBigButton(onTap: (){
                              cubit.joinInApp();
                            },color: purpleColor,altWidth: width,label: "join".tr(context),labelStyle: CustomTextStyle.fontBoldWhite16,borderRadius: 4,),
                            SizedBox(height: height*0.02,),
                            CustomBigButton(onTap: (){
                              context.push(RouterApp.kHomeView);
                            },altWidth: width,label: "skip".tr(context),labelStyle: CustomTextStyle.fontBold16,boxBorder: Border.all(color: purpleColor,width: 2),borderRadius: 4,),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
      }),
    );
  }
}



