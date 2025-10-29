import 'package:flutter/material.dart';

class AppColors {
  static const Color background = Color(0xFFf6f7f9);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color primary = Color(0xFF31d8b9);
  
  // Градиенты для плашек
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
  
    static const pulseGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFFFF6B6B), Color(0xFFc44747)],
  );


  static const Color neutral100 = Color(0xFFF7F8F9);
  static const Color neutral200 = Color(0xFFF0F1F3);
  static const Color neutral600 = Color(0xFF757575);
  static const Color buttonBorder = Color(0xFFE9ECEF);
  static const Color cardShadow = Color(0x1F000000); 
}