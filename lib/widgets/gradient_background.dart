import 'package:flutter/material.dart';
import '../theme.dart';

class GradientBackground extends StatelessWidget {
  final Widget child;

  const GradientBackground({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppTheme.backgroundDark,
            Color(0xFF2C2C2C), // Slightly lighter dark
          ],
        ),
      ),
      child: child,
    );
  }
}
