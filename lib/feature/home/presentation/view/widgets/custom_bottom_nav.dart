import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:taskaya/core/utilites/app_theme/colors.dart';
import 'package:taskaya/core/utilites/custom_localization/custom_app_localization.dart';
import 'package:taskaya/core/utilites/dimensions/responsive_layout.dart';
class BottomNavBar extends StatelessWidget {
  const BottomNavBar({
    super.key,
    required this.currIndex,
    required this.changeIndex,
  });

  final int currIndex;
  final void Function({required int currIndex})changeIndex;

  @override
  Widget build(BuildContext context) {
    final double height=BasicDimension.screenHeight(context);
    return BottomAppBar(
      elevation: 0,
      color: bottomNavBarColor,
      height: height*0.1,
      notchMargin: 0,
      shape: const CircularNotchedRectangle(),
      child: SizedBox(
        height: height*0.08,
        child: BottomNavigationBar(
            currentIndex:currIndex,
            onTap: (int index){
              changeIndex(currIndex: index);
            },
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