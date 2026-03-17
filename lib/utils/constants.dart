import 'package:flutter/material.dart';

class AppConstants {
  static const String appName = 'PoseGuide AI';

  // Colors
  static const MaterialColor primarySwatch = Colors.deepPurple;
  static const Color primaryColor = Colors.deepPurple;
  static const Color secondaryColor = Colors.pink;
  static const Color backgroundColor = Colors.grey;
  static const Color cardColor = Colors.white;

  // Spacing
  static const double paddingSmall = 8.0;
  static const double paddingMedium = 16.0;
  static const double paddingLarge = 24.0;

  // Text Styles
  static TextStyle headingStyle = const TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
  );

  static TextStyle subheadingStyle = const TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600,
  );

  static TextStyle bodyStyle = const TextStyle(
    fontSize: 16,
  );

  static TextStyle captionStyle = const TextStyle(
    fontSize: 14,
    color: Colors.grey,
  );
}