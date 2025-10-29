import 'package:flutter/material.dart';

class BackgroundGradient extends StatelessWidget {
  final double height;

  const BackgroundGradient({super.key, required this.height});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: height,
          decoration: BoxDecoration(gradient: _getTimeBasedGradient()),
        ),

        Positioned(top: 50, right: 10, child: _getTimeBasedIcon()),
      ],
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

  Widget _getTimeBasedIcon() {
    final hour =DateTime.now().hour;

    if (hour >= 6 && hour < 12) {
      return _buildSticker(icon: Icons.alarm, color: Colors.white);
    } else if (hour >= 12 && hour < 16) {
      return _buildSticker(icon: Icons.wb_sunny_rounded, color: Colors.yellow);
    } else if (hour >= 16 && hour < 20) {
      return _buildSticker(icon: Icons.light_mode, color: Colors.orange);
    } else {
      return _buildSticker(
        icon: Icons.nightlight_rounded,
        color: Color(0xfffee7b2),
      );
    }
  }

  Widget _buildSticker({required IconData icon, required Color color}) {
    return Container(
      padding: const EdgeInsets.all(12),
      child: Icon(icon, color: color, size: 80),
    );
  }
}
