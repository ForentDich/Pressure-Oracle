import 'package:flutter/material.dart';

class BackgroundGradient extends StatelessWidget {
  final double height;
  
  const BackgroundGradient({
    super.key,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: height,
      decoration: BoxDecoration(
        gradient: _getTimeBasedGradient(),
      ),
    );
  }

  Gradient _getTimeBasedGradient() {
    final hour = DateTime.now().hour;
    
    if (hour >= 5 && hour < 10) {
      return const LinearGradient(
        colors: [
          Color(0xFF84E9DF),
          Color(0xFF6BD4CA),
        ],
       begin: Alignment.centerRight,
        end: Alignment.centerLeft,
      );
    } else if (hour >= 10 && hour < 16) {
      return const LinearGradient(
        colors: [
          Color(0xFF3F9AE8), 
          Color(0xFF2D88D6), 
        ],
       begin: Alignment.centerRight,
        end: Alignment.centerLeft,
      );
    } else if (hour >= 16 && hour < 20) {
      return const LinearGradient(
        colors: [
          Color(0xFFEC7263),
          Color(0xFFDA6152),
        ],
        begin: Alignment.centerRight,
        end: Alignment.centerLeft,
      );
    } else {
      return const LinearGradient(
        colors: [
          Color(0xFF8651AB),
          Color(0xFF744099),
        ],
        begin: Alignment.centerRight,
        end: Alignment.centerLeft,
      );
    }
  }
}