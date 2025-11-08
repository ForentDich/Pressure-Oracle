import 'package:flutter/material.dart';

class TextStyles {
  static const TextStyle headlineLarge = TextStyle(
    fontFamily: 'Manrope',
    fontSize: 28,
    fontWeight: FontWeight.w700, // 700 = Bold
    color: Colors.black87,
  );
  
  static const TextStyle titleMedium = TextStyle(
    fontFamily: 'Manrope', 
    fontSize: 18,
    fontWeight: FontWeight.w600, // 600 = SemiBold
    color: Colors.black87,
  );
  
  static const TextStyle bodyMedium = TextStyle(
    fontFamily: 'Manrope',
    fontSize: 16, 
    fontWeight: FontWeight.w500, // 500 = Medium
    color: Colors.black54,
  );
  
  static const TextStyle labelSmall = TextStyle(
    fontFamily: 'Manrope',
    fontSize: 12,
    fontWeight: FontWeight.w500, // 500 = Medium
    color: Colors.white,
  );

static const TextStyle labelXSmall = TextStyle(
  fontFamily: 'Manrope',
  fontSize: 16,
  fontWeight: FontWeight.w600,
  color: Colors.white,
);
  }