import 'package:flutter/material.dart';

Widget badgeWidget({
  required String imagePath,
  required double size,
  required Color borderColor1,
  required Color borderColor2,
}) {
  return Container(
    width: size,
    height: size,
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      border: Border.all(
        width: 4,
        color: borderColor1, // Primary border color
      ),
      gradient: LinearGradient(
        colors: [borderColor1, borderColor2], // Gradient for the border
      ),
    ),
    child: Center(
      child: Image.asset(
        imagePath,
        width: size * 0.6,
        height: size * 0.6,
      ),
    ),
  );
}
