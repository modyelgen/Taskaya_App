import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:taskaya/core/utilites/app_theme/colors.dart';
import 'package:taskaya/core/utilites/app_theme/text_style.dart';
import 'package:taskaya/core/utilites/dimensions/responsive_layout.dart';
import 'package:taskaya/core/utilites/widgets/custom_profile_pic.dart';
import 'package:taskaya/core/utilites/widgets/custom_text_form_field.dart';
import 'package:taskaya/feature/home/presentation/manager/home_bloc.dart';
import 'package:taskaya/feature/on_boarding_screen/presentation/view/widgets/otpion_pick_image.dart';
import 'package:taskaya/feature/profile/presentation/view/widgets/about_app_tiles.dart';
import 'package:taskaya/feature/profile/presentation/view/widgets/app_settings_tiles.dart';
import 'package:taskaya/feature/profile/presentation/view/widgets/remind_complete_tasks.dart';
import 'package:taskaya/feature/settings/presentation/manager/settings_bloc.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key,required this.name,required this.profilePath});
  final String name;
  final String profilePath;

  @override
  Widget build(BuildContext context) {
    final double width=BasicDimension.screenWidth(context);
    final double height=BasicDimension.screenHeight(context);
    var bloc=BlocProvider.of<SettingsBloc>(context);
    return BlocConsumer<SettingsBloc,SettingsState>(
        builder: (context,state){
          return Scaffold(
            //resizeToAvoidBottomInset: false,
            body: ListView(
              padding: EdgeInsets.symmetric(horizontal: width*0.035,vertical: height*0.02),
              children: [
                Center(child: Text("Profile",style: CustomTextStyle.fontBold18,)),
                SizedBox(height: height*0.01,),
                Center(child: SmallProfilePic(width: width*2, profilePath: profilePath)),
                Center(child: Text(name,style: CustomTextStyle.fontBold16,)),
                SizedBox(height: height*0.025,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    RemainOrCompleteTasks(width: width, height: height, text: "10 Task left"),
                    RemainOrCompleteTasks(width: width, height: height, text: "10 Task done"),
                  ],
                ),
                SizedBox(height: height*0.025,),
                Text("Settings",style: CustomTextStyle.fontNormal14,),
                AppSettingListTiles(
                  changeNotify:({required bool value}){
                    bloc.add(ChangeNotificationEvent(notify:value));
                } ,notify:bloc.enableNotification, changeLang: () {
                    bloc.add(ChangeLanguageEvent());
                }, changeMood: () {
                    bloc.add(ToggleModeEvent());
                },),
                SizedBox(height: height*0.02,),
                Text("Account",style: CustomTextStyle.fontNormal14,),
                AccountListTiles(
                  showImageSheet: ()async {
                  await showModalBottomSheet(context: context, builder:(context){
                    return OptionPickImage(width: width, height: height, deleteImage: (){
                      bloc.add(DeleteCurrentImageEvent(name: name));
                    }, pickImage: ({required ImageSource source}){
                      bloc.add(OptionPickImageEvent(source: source, name: name));
                      Navigator.pop(context);
                    });
                  } );
                },
                  showNameSheet: ()async{
                    showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        builder: (context){
                      return Padding(
                        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                        child: CustomChangeNameBottomSheet(
                          width: width, 
                          onEdit: (){
                            bloc.add(ChangeCurrentNameEvent(name: name));
                            Navigator.pop(context);
                          },
                          height: height, controller:bloc.nameController,),
                      );
                    });
                  },
                ),
                SizedBox(height: height*0.02,),
                Text("Taskaya",style: CustomTextStyle.fontNormal14,),
                const AboutAppListTiles(),
                SizedBox(height: height*0.02,),
                ListTile(
                  title: Text("Delete Account",style: CustomTextStyle.fontNormal14.copyWith(color: deleteColor),),
                  trailing: IconButton(onPressed: (){}, icon: Icon(CupertinoIcons.delete_simple,color: deleteColor,)),
                ),
              ],
            ),
          );
        },
        listener:(context,state){
          var homeBloc=BlocProvider.of<HomeBloc>(context);
          if(state is ChangeProfilePictureSuccessState||state is ChangeNameSuccessState){
            homeBloc.add(LoadCustomDataEvent());
          }
        });
  }
}





class AccountListTiles extends StatelessWidget {
  const AccountListTiles({super.key,required this.showImageSheet,required this.showNameSheet});
  final Future<dynamic> Function() showImageSheet;
  final Future<dynamic> Function() showNameSheet;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading:const Icon(Icons.perm_identity_rounded),
          title: const Text("Change Account Name"),
          trailing: CupertinoButton(onPressed: showNameSheet, child: const Icon(Icons.arrow_forward_ios_rounded)),
        ),
        ListTile(
          leading: const Icon(CupertinoIcons.photo_fill),
          title: const Text("Change Account Picture"),
          trailing: CupertinoButton(onPressed: showImageSheet, child: const Icon(Icons.arrow_forward_ios_rounded)),
        ),
      ],
    );
  }
}

class CustomChangeNameBottomSheet extends StatelessWidget {
  const CustomChangeNameBottomSheet({super.key,required this.width,required this.height,required this.controller,required this.onEdit});
  final double width;
  final double height;
  final TextEditingController controller;
  final void Function() onEdit;
  
  @override
  Widget build(BuildContext context) {
    return Container(
      padding:const EdgeInsets.all(10),
      width: width*0.9,
       height: height*0.26,
      decoration: BoxDecoration(
        color: bottomNavBarColor,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Column(
        children: [
          Text("Change Account Name",style: CustomTextStyle.fontBoldWhite16,),
          SizedBox(height: height*0.01,),
          SizedBox(
            width: width*0.8,
            child: const Divider(
              color: Color(0xff979797),
            ),
          ),
          SizedBox(height: height*0.01,),
          SizedBox(
             width: width*0.75,
             child: CustomTextFormField(
              border: 4,
              style: CustomTextStyle.fontNormal14.copyWith(color: Colors.white),
              borderColor: borderColor,
              controller:controller,
          ),
           ),
          SizedBox(height: height*0.015,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(onPressed: (){
                Navigator.pop(context);
              },child:Text("Cancel",style: CustomTextStyle.fontNormal14.copyWith(color: purpleColor),),),
              GestureDetector(
                  onTap: onEdit,
                  child: RemainOrCompleteTasks(width: width*0.8, height: height*0.8, text: "Edit",backGroundColor: purpleColor,))
            ],
          )
        ],
      ),
    );
  }
}



