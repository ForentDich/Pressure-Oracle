import 'package:flutter/material.dart';

class AppColors {
  static const Color background = Color(0xFFFAFAFA);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color primary = Color(0xFF2CAA92);
  
  // Градиенты для плашек
  static const Gradient pressureGradient = LinearGradient(
    colors: [Color(0xFFFF6B6B), Color(0xFFEE5A5A)],
  );
  
  static const Gradient sugarGradient = LinearGradient(
    colors: [Color(0xFFFFA726), Color(0xFFF57C00)],
  );
  
  static const Gradient weightGradient = LinearGradient(
    colors: [Color(0xFF42A5F5), Color(0xFF1976D2)],
  );
  
  static const Gradient statusGradient = LinearGradient(
    colors: [Color(0xFF66BB6A), Color(0xFF388E3C)],
  );
}