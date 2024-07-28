import 'package:flutter/painting.dart';

Color getRelatedColor(Color color) {
  // Convert the color to HSL
  final hslColor = HSLColor.fromColor(color);

  // Adjust the lightness (or saturation) to get a related color
  final relatedHslColor = hslColor.withLightness(
    (hslColor.lightness + 0.4) % 1.0, // Change lightness by 40%
  );

  // Convert the HSL color back to a Color
  return relatedHslColor.toColor();
}