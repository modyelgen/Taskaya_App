import 'package:flutter/material.dart';

class GetColor{
  final BuildContext context;
  GetColor({required this.context});

  Color getInverseColor(){
    return Theme.of(context).colorScheme.onInverseSurface;
  }
  Color getNormalColor(){
    return Theme.of(context).colorScheme.onSurface;
  }
}

