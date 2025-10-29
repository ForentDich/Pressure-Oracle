
import 'package:flutter/material.dart';
import '../theme/text_styles.dart';

class HealthCard extends StatelessWidget {
  final String title;
  final String value;
  final String unit;
  final String lastUpdate;
  final Gradient gradient;
  final Widget icon;
  final VoidCallback? onTap;

  const HealthCard({
    super.key,
    required this.title,
    required this.value,
    required this.unit,
    required this.lastUpdate,
    required this.gradient,
    required this.icon,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          gradient: gradient,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Text(
                    title,
                    style: TextStyles.labelXSmall,
                  ),
                  
                  const Spacer(),
                  

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        value,
                        style: TextStyles.headlineLarge.copyWith(
                          color: Colors.white,
                          fontSize: 28,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        unit,
                        style: TextStyles.bodyMedium.copyWith(
                          color: Colors.white.withOpacity(0.9),
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                  
                  const Spacer(),
                  

                  Align(
                    alignment: Alignment.bottomRight,
                    child: Text(
                      lastUpdate,
                      style: TextStyles.bodyMedium.copyWith(
                        color: Colors.white.withOpacity(0.9),
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            

            Positioned(
              top: 0,
              right: 0,
              child: Container(
                width: 48,
                height: 56,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(24),
                    bottomLeft: Radius.circular(24),
                  ),
                ),
                child: icon,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
