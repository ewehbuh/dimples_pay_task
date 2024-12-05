import 'package:flutter/material.dart';

class AppTheme {
  // Primary Color
  static const Color primaryStart = Color(0xFF4A90E2); // Soft Blue
  static const Color primaryEnd = Color(0xFF50E3C2); // Light Teal

  // Secondary Color
  static const Color secondaryColor = Color(0xFFF5A623); // Warm Yellow (for accents and call-to-action)

  // Background Color
  static const Color backgroundColor = Color(0xFFF9F9F9); // Soft off-white background

  // Card Background Color
  static const Color cardBackgroundColor = Color(0xFFFFFFFF); // White for card backgrounds

  // Text Colors
  static const Color textPrimaryColor = Color(0xFF333333); // Dark grey for primary text
  static const Color textSecondaryColor = Color(0xFF777777); // Lighter grey for secondary text

  // Button Color
  static const Color buttonColor = Color(0xFF4A90E2); // Primary button color

  // Gradient Color for the AppBar
  static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [primaryStart, primaryEnd],
  );

  // Theme Data
  static ThemeData getThemeData() {
    return ThemeData(
      scaffoldBackgroundColor: backgroundColor,
      fontFamily: 'Roboto',
      appBarTheme: const AppBarTheme(
        backgroundColor: primaryStart,
        elevation: 0,
      ),
      textTheme: TextTheme(
        bodyLarge: TextStyle(color: textPrimaryColor), // Updated to bodyLarge
        bodyMedium: TextStyle(color: textSecondaryColor), // Updated to bodyMedium
        headlineLarge: TextStyle(color: textPrimaryColor), // Updated to headlineLarge
        headlineMedium: TextStyle(color: textPrimaryColor), // Updated to headlineMedium
      ),
      buttonTheme: ButtonThemeData(
        buttonColor: buttonColor, // Set default button color
      ),
      cardTheme: CardTheme(
        color: cardBackgroundColor,
        elevation: 4,
        shadowColor: Colors.black26,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}
