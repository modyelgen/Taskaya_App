

import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:taskaya/core/utilites/app_theme/colors.dart';

Future<void> showPopUpDialog({required BuildContext context,required double width}) async{
  showGeneralDialog(
    context: context,
    barrierDismissible: true,
    useRootNavigator: false,
    barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
    barrierColor: Colors.black54,
    transitionDuration: const Duration(milliseconds: 300),
    pageBuilder: (BuildContext buildContext, Animation animation, Animation secondaryAnimation) {
      return  Center(
        child: CircleAvatar(
          radius: width*0.125,
          backgroundColor: checkColor,
          child:Icon(CupertinoIcons.hand_thumbsup,color: Colors.white,size: width*0.1,)
        ),
      );
    },
    transitionBuilder: (context, animation, secondaryAnimation, child) {
      return ScaleTransition(
        scale: CurvedAnimation(
          parent: animation,
          curve: Curves.easeOutBack,
        ),
        child: child,
      );
    },
  );
  Timer(const Duration(seconds: 1), (){Navigator.pop(context);});
}