import 'package:flutter/material.dart';
import 'package:taskaya/core/utilites/app_theme/colors.dart';

class AddButtonToTask extends StatelessWidget {
  const AddButtonToTask({
    super.key,
    this.onTap
  });
  final void Function()?onTap;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(onPressed: onTap,style: ElevatedButton.styleFrom(backgroundColor: bottomNavBarColor,shape:const CircleBorder()), child: const Icon(Icons.add),);
  }
}