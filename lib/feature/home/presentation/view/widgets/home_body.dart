import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:taskaya/core/utilites/app_theme/colors.dart';
import 'package:taskaya/core/utilites/app_theme/text_style.dart';
import 'package:taskaya/core/utilites/custom_localization/custom_app_localization.dart';
import 'package:taskaya/core/utilites/widgets/custom_profile_pic.dart';
import 'package:taskaya/core/utilites/widgets/custom_text_form_field.dart';
import 'package:taskaya/feature/home/presentation/manager/home_bloc.dart';
import 'package:taskaya/feature/home/presentation/view/widgets/empty_task.dart';
import 'package:taskaya/feature/home/presentation/view/widgets/tasks_list.dart';
class HomeBody extends StatelessWidget {
  const HomeBody({
    super.key,
    required this.width,
    required this.bloc,
    required this.height,
  });

  final double width;
  final HomeBloc bloc;
  final double height;

  @override
  Widget build(BuildContext context) {
    return bloc.isLoading?
    const Center(child: CircularProgressIndicator()) :
    Padding(
      padding: EdgeInsetsDirectional.symmetric(
        horizontal: width * 0.05,
        vertical: height * 0.015,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              IconButton(onPressed: (){
                Scaffold.of(context).openDrawer();
              }, icon: const Icon(Icons.sort_rounded)),
              const Spacer(),
              Center(child: Text("task".tr(context),style: CustomTextStyle.fontBold21,)),
              const Spacer(),
              SmallProfilePic(width: width, profilePath: bloc.profilePicPath),
            ],
          ),
          SizedBox(height: height*0.02,),
          CustomTextFormField(borderColor: customBorderColor,borderWidth: 0.8,border: 8,suffix: const Icon(CupertinoIcons.search),label: "searchLabel".tr(context),),
          SizedBox(height: height*0.015,),
          bloc.taskList.isEmpty&&bloc.completedList.isEmpty?
          EmptyTasks(width: width, height: height):
          TasksList(height: height, width: width,bloc: bloc,),
        ],
      ),
    );
  }
}



