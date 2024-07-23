import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:taskaya/core/utilites/app_theme/colors.dart';
import 'package:taskaya/core/utilites/custom_localization/custom_app_localization.dart';
import 'package:taskaya/feature/home/presentation/manager/home_bloc.dart';
class BottomNavBar extends StatelessWidget {
  const BottomNavBar({
    super.key,
    required this.height,
    required this.bloc,
  });

  final double height;
  final HomeBloc bloc;

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      elevation: 0,
      color: bottomNavBarColor,
      height: height*0.12,
      notchMargin: 0,
      shape: const CircularNotchedRectangle(),
      child: SizedBox(
        height: height*0.1,
        child: BottomNavigationBar(
            currentIndex: bloc.bottomNavCurrIndex,
            onTap: (int index){
              bloc.add(ChangeBottomNavIconEvent(currIndex: index));
            },
            iconSize: 30,
            type: BottomNavigationBarType.fixed,
            selectedItemColor: Colors.white,
            unselectedItemColor: Colors.grey,
            backgroundColor: bottomNavBarColor,
            selectedIconTheme: const IconThemeData(color:Colors.white),
            unselectedIconTheme: const IconThemeData(color:Colors.grey),
            showUnselectedLabels: true,
            elevation: 0,

            items: [
              BottomNavigationBarItem(icon: const Icon(CupertinoIcons.house_alt_fill),label: "task".tr(context),),
              BottomNavigationBarItem(icon: const Icon(CupertinoIcons.calendar),label: "calendar".tr(context),),
              BottomNavigationBarItem(icon: const Icon(CupertinoIcons.time,),label: "focus".tr(context),),
              BottomNavigationBarItem(icon: const Icon(CupertinoIcons.person_alt,),label: "profile".tr(context),),
            ]),
      ),
    );
  }
}