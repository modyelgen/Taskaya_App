import 'package:flutter/cupertino.dart';

class BasicDimension{
  static double screenHeight(BuildContext context){
    final size = MediaQuery.of(context).size;
    if (MediaQuery.of(context).orientation == Orientation.portrait) {
      return size.height;
    } else {
      return size.width;
    }
  }
  static double screenWidth(BuildContext context){
    final size = MediaQuery.of(context).size;
    if (MediaQuery.of(context).orientation == Orientation.portrait) {
      return size.width;
    } else {
      return size.height;
    }
  }
}