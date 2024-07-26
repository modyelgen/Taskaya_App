import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:taskaya/core/utilites/app_theme/colors.dart';
import 'package:taskaya/core/utilites/app_theme/text_style.dart';
import 'package:taskaya/core/utilites/custom_localization/custom_app_localization.dart';
import 'package:taskaya/core/utilites/widgets/custom_profile_pic.dart';
import 'package:taskaya/core/utilites/widgets/custom_text_form_field.dart';
import 'package:taskaya/feature/home/presentation/manager/home_bloc.dart';
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
    return
      bloc.isLoading?
      const Center(child: CircularProgressIndicator()) :
      Padding(
        padding: EdgeInsets.symmetric(
          horizontal: width * 0.03,
          vertical: height * 0.015,
        ),
        child: Column(
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
            SizedBox(height: height*0.015,),
            SizedBox(
              //height: height*0.06,
                child: CustomTextFormField(borderColor: borderColor,borderWidth: 0.2,border: 4,suffix: const Icon(CupertinoIcons.search),label: "searchLabel".tr(context),)),
            SizedBox(height: height*0.015,),
            Image.asset("assets/home/empty_tasks.png",fit: BoxFit.fitHeight,width: width,height: height*0.25,),
            SizedBox(height: height*0.015,),
            Column(
              children: [
                Text("emptyTaskTitle".tr(context),style: CustomTextStyle.fontBold21,),
                SizedBox(height: height*0.009,),
                Text("emptyTaskSec".tr(context),style: CustomTextStyle.fontBold16,),
              ],
            ),
            SizedBox(
              child: bloc.tempIcon,
            ),
          ],
        ),
    );
  }
}