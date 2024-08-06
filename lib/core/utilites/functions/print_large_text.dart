import 'dart:convert';

import 'package:flutter/foundation.dart';

void printLargeMap(Map<String, dynamic> largeMap,) {
  // Convert the map to a JSON string
  String jsonString = jsonEncode(largeMap);

  int startIndex = 0;
  while (startIndex < jsonString.length) {
    int endIndex = startIndex + 2000;
    if (endIndex > jsonString.length) {
      endIndex = jsonString.length;
    }
    if (kDebugMode) {
      print(jsonString.substring(startIndex, endIndex));
    }
    startIndex = endIndex;
  }
}