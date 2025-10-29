import 'package:flutter/material.dart';
import '../widgets/background_gradient.dart';
import '../widgets/header_content.dart';
import '../widgets/metrics_panel.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          final screenHeight = constraints.maxHeight;
          final headerHeight = screenHeight * 1;
          final panelTop = headerHeight * 0.18; 
          
          return Stack(
            children: [
              BackgroundGradient(height: headerHeight),
              HeaderContent(),
              MetricsPanel(top: panelTop),   
            ],
          );
        },
      ),
    );
  }
}