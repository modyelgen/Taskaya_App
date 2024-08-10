import 'package:flutter/material.dart';
import 'package:taskaya/core/utilites/dimensions/responsive_layout.dart';

class CustomAlertWidget extends StatelessWidget {
  const CustomAlertWidget({super.key,this.title,this.leftOption,this.rightOption});
  final Widget? title;
  final Widget? leftOption;
  final Widget? rightOption;
  @override
  Widget build(BuildContext context) {
    final double height=BasicDimension.screenHeight(context);
    final double width=BasicDimension.screenWidth(context);
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: SizedBox(
        width: width*0.8,
        // height: height*0.2,
        child: Material(
            child: Padding(
              padding: EdgeInsetsDirectional.all(width*0.02),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if(title!=null)title!,
                  SizedBox(
                    height: height*0.03,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      if(leftOption!=null)leftOption!,
                      if(rightOption!=null)rightOption!,
                    ],
                  )
                ],
              ),
            )
        ),
      ),
    );
  }
}
