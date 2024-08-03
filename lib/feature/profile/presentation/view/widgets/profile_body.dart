import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:taskaya/core/utilites/app_theme/colors.dart';
import 'package:taskaya/core/utilites/app_theme/text_style.dart';
import 'package:taskaya/core/utilites/widgets/custom_profile_pic.dart';
import 'package:taskaya/feature/on_boarding_screen/presentation/view/widgets/otpion_pick_image.dart';
import 'package:taskaya/feature/profile/presentation/view/widgets/about_app_tiles.dart';
import 'package:taskaya/feature/profile/presentation/view/widgets/app_settings_tiles.dart';
import 'package:taskaya/feature/profile/presentation/view/widgets/custom_account_list_tile.dart';
import 'package:taskaya/feature/profile/presentation/view/widgets/custom_change_name_bottom_sheet.dart';
import 'package:taskaya/feature/profile/presentation/view/widgets/remind_complete_tasks.dart';
import 'package:taskaya/feature/settings/presentation/manager/settings_bloc.dart';
class ProfileBody extends StatelessWidget {
  const ProfileBody({
    super.key,
    required this.width,
    required this.height,
    required this.profilePath,
    required this.name,
    required this.bloc,
    required this.taskUn,
    required this.taskC,
  });

  final double width;
  final double height;
  final String profilePath;
  final String name;
  final SettingsBloc bloc;
  final int taskC;
  final int taskUn;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              RemainOrCompleteTasks(width: width, height: height, text: "$taskUn  Task left"),
              RemainOrCompleteTasks(width: width, height: height, text: "$taskC  Task done"),
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
  }
}
