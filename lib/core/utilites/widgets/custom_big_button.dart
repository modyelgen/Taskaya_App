import 'package:flutter/material.dart';
import 'package:taskaya/core/utilites/dimensions/responsive_layout.dart';

class CustomBigButton extends StatelessWidget {
  const CustomBigButton({super.key,this.altWidth,this.boxBorder,this.onTap,this.labelStyle,this.label,this.color,this.isLoading=false,this.enable=false,this.borderRadius});
  final void Function()?onTap;
  final String?label;
  final Color? color;
  final bool isLoading;
  final double?altWidth;
  final bool enable;
  final double?borderRadius;
  final TextStyle? labelStyle;
  final BoxBorder?boxBorder;
  @override
  Widget build(BuildContext context) {
    final double height=BasicDimension.screenHeight(context);
    final double width=BasicDimension.screenWidth(context);
    return InkWell(
        onTap:onTap,
        child: Container(
          width:altWidth??width*0.4,
          height:height*0.055,
          decoration: BoxDecoration(
            border: boxBorder,
            borderRadius: BorderRadius.all(Radius.circular(borderRadius??20),),
            color:color?? Theme.of(context).colorScheme.onInverseSurface,),
          child: Center(
              child: isLoading? const CircularProgressIndicator(color: Colors.white,) :
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(label??"",style: labelStyle??TextStyle(fontWeight: FontWeight.bold,fontSize: 18,color: Theme.of(context).colorScheme.onPrimary),),
                  enable?const Padding(
                    padding:  EdgeInsets.only(left: 16.0),
                    child:  Icon(Icons.arrow_forward_rounded,color: Colors.white,),
                  ):const SizedBox(height: 0,)
                ],
              )),));
  }
}