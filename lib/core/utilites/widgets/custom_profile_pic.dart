import 'dart:io';

import 'package:flutter/material.dart';
import 'package:taskaya/core/utilites/app_theme/colors.dart';

class SmallProfilePic extends StatelessWidget {
  const SmallProfilePic({
    super.key,
    required this.width,
    required this.profilePath,
  });

  final double width;
  final String profilePath;


  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundImage:profilePath != "null"
          ? FileImage(File(profilePath))
          : const AssetImage("assets/home/default_profile.png") as ImageProvider,
      backgroundColor: buttonColor,
      radius: width*0.06,
    );
  }
}