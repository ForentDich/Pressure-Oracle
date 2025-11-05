// colors.dart
import 'package:flutter/material.dart';

class AppColors {
  static const Color background = Color(0xFFf6f7f9);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color primary = Color(0xFF31d8b9);
  
  // Neutral colors
  static const Color neutral50 = Color(0xFFFAFAFA);
  static const Color neutral100 = Color(0xFFF7F8F9);
  static const Color neutral200 = Color(0xFFF0F1F3);
  static const Color neutral300 = Color(0xFFE9ECEF);
  static const Color neutral400 = Color(0xFFCED4DA);
  static const Color neutral500 = Color(0xFFADB5BD);
  static const Color neutral600 = Color(0xFF757575);
  static const Color neutral700 = Color(0xFF495057);
  static const Color neutral800 = Color(0xFF343A40);
  static const Color neutral900 = Color(0xFF212529);

  // Semantic colors
  static const Color actionPrimary = Color(0xFF4A4C87);
  static const Color buttonBorder = Color(0xFFE9ECEF);
  static const Color cardShadow = Color(0x1F000000);
  
  // Status colors
  static const Color error50 = Color(0xFFFEF2F2);
  static const Color error100 = Color(0xFFFEE2E2);
  static const Color error200 = Color(0xFFFECACA);
  static const Color error300 = Color(0xFFFCA5A5);
  static const Color error400 = Color(0xFFF87171);
  static const Color error500 = Color(0xFFEF4444);
  static const Color error600 = Color(0xFFDC2626);
  static const Color error700 = Color(0xFFB91C1C);
  static const Color error800 = Color(0xFF991B1B);
  static const Color error900 = Color(0xFF7F1D1D);

  static const Color success500 = Color(0xFF22C55E);
  static const Color warning500 = Color(0xFFEAB308);
  static const Color info500 = Color(0xFF3B82F6);

  // Gradients
  static const Gradient pressureGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF667eea), Color(0xFF764ba2)],
  );
  
  static const Gradient sugarGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFFFFA726), Color(0xFFF57C00)],
  );
  
  static const Gradient weightGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF42A5F5), Color(0xFF1976D2)],
  );
  
  static const Gradient pulseGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFFFF6B6B), Color(0xFFc44747)],
  );
}