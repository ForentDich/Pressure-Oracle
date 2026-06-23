import 'package:flutter/material.dart';

class BackgroundGradient extends StatelessWidget {
  final double height;

  const BackgroundGradient({super.key, required this.height});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: height,
      decoration: BoxDecoration(gradient: _getTimeBasedGradient()),
    );
  }

  Gradient _getTimeBasedGradient() {
    final hour = DateTime.now().hour;

    if (hour >= 6 && hour < 12) {
      return const LinearGradient(
        colors: [Color(0xFFFF0061), Color(0xFFFEC194)],
        stops: [0, 0.25],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      );
    } else if (hour >= 12 && hour < 16) {
      return const LinearGradient(
        colors: [Color(0xFF4418b8), Color(0xFF00c0ff)],
        stops: [0, 0.25],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      );
    } else if (hour >= 16 && hour < 20) {
      return const LinearGradient(
        stops: [0, 0.25],
        colors: [Color(0xFFff2525), Color(0xFFffe53b)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      );
    } else {
      return const LinearGradient(
        stops: [0, 0.25],
        colors: [Color(0xFF4a3cdb), Color(0xFFff0a6c)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      );
    }
  }

}
