import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:taskaya/core/utilites/app_theme/colors.dart';
import 'package:taskaya/core/utilites/custom_localization/custom_app_localization.dart';

class AppSettingListTiles extends StatelessWidget {
  const AppSettingListTiles({super.key,required this.notify,required this.changeNotify,required this.changeLang,required this.changeMood});
  final bool notify;
  final void Function({required bool value})changeNotify;
  final void Function()changeMood;
  final void Function()changeLang;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading:const Icon(Icons.dark_mode),
          title:const Text("Change Mode"),
          trailing:CupertinoButton(onPressed: changeMood, child:const Icon(CupertinoIcons.shuffle_thick)),
        ),
        ListTile(
          leading: const Icon(CupertinoIcons.bell_fill),
          title: const Text("Notification"),
          trailing: CupertinoSwitch(value: notify, onChanged: (bool v) {
            changeNotify(value: v);
          },activeColor: purpleColor,),
        ),
        ListTile(
          leading: const Icon(CupertinoIcons.globe),
          title: Text("english".tr(context)),
          trailing:CupertinoButton(onPressed: changeLang, child: const Icon(CupertinoIcons.shuffle_thick)),
        ),
      ],
    );
  }
}