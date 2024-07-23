import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskaya/core/utilites/app_theme/text_style.dart';
import 'package:taskaya/core/utilites/custom_localization/custom_app_localization.dart';
import 'package:taskaya/core/utilites/widgets/custom_profile_pic.dart';
import 'package:taskaya/feature/settings/presentation/manager/settings_bloc.dart';
class CustomDrawer extends StatelessWidget {
  const CustomDrawer({
    super.key,
    required this.width,
    required this.height,
    required this.profilePath,
    required this.name,
  });
  final double width;
  final double height;
  final String profilePath;
  final String name;
  @override
  Widget build(BuildContext context) {
    var bloc=BlocProvider.of<SettingsBloc>(context);
    return  Drawer(
      width: width*0.75,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            SizedBox(height: height*0.025,),
            Align(
              alignment: Alignment.topLeft,
              child: CircleAvatar(
                  child: IconButton(onPressed: (){
                    bloc.add(ToggleModeEvent());
                  }, icon:Icon(Icons.dark_mode,color: Theme.of(context).colorScheme.onInverseSurface,))),
            ),
            SizedBox(height: height*0.025,),
            SmallProfilePic(width: width*3, profilePath: profilePath),
            SizedBox(height: height*0.025,),
            SizedBox(
                width: width*0.5,
                child: Center(child: Text(name,style: CustomTextStyle.fontBold16,maxLines: 2,))),
            ListTile(
              title: Text("english".tr(context)),
              trailing: IconButton(icon: const Icon(Icons.language_rounded), onPressed: (){
                bloc.add(ChangeLanguageEvent());
              }),
            ),
          ],
        ),
      ),
    );
  }
}