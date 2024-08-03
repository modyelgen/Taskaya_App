import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskaya/core/utilites/dimensions/responsive_layout.dart';
import 'package:taskaya/feature/home/presentation/manager/home_bloc.dart';
import 'package:taskaya/feature/profile/presentation/view/widgets/profile_body.dart';
import 'package:taskaya/feature/settings/presentation/manager/settings_bloc.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key,required this.name,required this.profilePath,required this.taskUnCompleted,required this.taskCompleted});
  final String name;
  final String profilePath;
  final int taskCompleted;
  final int taskUnCompleted;
  @override
  Widget build(BuildContext context) {
    final double width=BasicDimension.screenWidth(context);
    final double height=BasicDimension.screenHeight(context);
    var bloc=BlocProvider.of<SettingsBloc>(context);
    return BlocConsumer<SettingsBloc,SettingsState>(
        builder: (context,state){
          return ProfileBody(width: width, height: height, profilePath: profilePath, name: name, bloc: bloc,taskC: taskCompleted,taskUn: taskUnCompleted,);
        },
        listener:(context,state){
          var homeBloc=BlocProvider.of<HomeBloc>(context);
          if(state is ChangeProfilePictureSuccessState||state is ChangeNameSuccessState){
            homeBloc.add(LoadCustomDataEvent());
          }
        });
  }
}












