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
        colors: [Color(0xFF2fe593), Color(0xFF91feb7)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      );
    } else if (hour >= 12 && hour < 16) {
      return const LinearGradient(
        colors: [Color(0xFF2f93e5), Color(0xFF91b9fe)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      );
    } else if (hour >= 16 && hour < 20) {
      return const LinearGradient(
        colors: [Color(0xFFfa8734), Color(0xFFfad15b)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      );
    } else {
      return const LinearGradient(
        colors: [Color(0xFF4e3bac), Color(0xFFdc74b1)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      );
    }
  }

  Widget _getTimeBasedIcon() {
    final hour = DateTime.now().hour;

    if (hour >= 6 && hour < 12) {
      return _buildSticker(icon: Icons.alarm, color: Colors.white);
    } else if (hour >= 12 && hour < 16) {
      return _buildSticker(icon: Icons.wb_sunny_rounded, color: Colors.yellow);
    } else if (hour >= 16 && hour < 20) {
      return _buildSticker(icon: Icons.light_mode, color: Colors.yellow);
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
