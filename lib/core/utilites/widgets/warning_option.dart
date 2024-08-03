import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:taskaya/core/utilites/app_theme/colors.dart';
import 'package:taskaya/core/utilites/app_theme/text_style.dart';
import 'package:taskaya/core/utilites/dimensions/responsive_layout.dart';
import 'package:taskaya/core/utilites/widgets/custom_alert_widget.dart';
import 'package:taskaya/core/utilites/widgets/custom_big_button.dart';

class WarningOption extends StatelessWidget {
  const WarningOption({super.key,this.yesFunction,this.noFunction});
  final void Function()?yesFunction;
  final void Function()?noFunction;
  @override
  Widget build(BuildContext context) {
    final double width=BasicDimension.screenWidth(context);
    return Center(
      child: CustomAlertWidget(
        title: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(CupertinoIcons.exclamationmark_triangle_fill,color: const Color(0xffFFB636),size:width*0.1 ,),
            Text("Are you Sure to Delete ?",style: CustomTextStyle.fontBold18,overflow: TextOverflow.ellipsis,),
          ],
        ),
        rightOption: CustomBigButton(altWidth:width*0.3 ,label:"Yes",color: deleteColor,labelStyle: CustomTextStyle.fontBoldWhite16,onTap: (){
          Navigator.pop(context,true);
        },),
        leftOption: TextButton(onPressed: (){
          Navigator.pop(context,false);
        },child: Text("No",style: CustomTextStyle.fontNormal16.copyWith(color: buttonColor),)),
      ),
    );
  }
}

Future<bool> showConfirmDialog(BuildContext context) async {
  return await showGeneralDialog<bool>(
    context: context,
    barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
    pageBuilder: (BuildContext context,ani,anu) {
      return const WarningOption();
    },
  ) ?? false; // return false if dialog is dismissed by tapping outside
}
