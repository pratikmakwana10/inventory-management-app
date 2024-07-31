import 'package:flutter/material.dart';

class GradientFloatingActionButton extends StatelessWidget {
  final VoidCallback onPressed;
  final IconData icon;
  final List<Color> gradientColors;

  const GradientFloatingActionButton({
    required this.onPressed,
    required this.icon,
    required this.gradientColors,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          bottom: 16,
          right: 16,
          child: Container(
            width: 56, // Width of FloatingActionButton
            height: 56, // Height of FloatingActionButton
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: gradientColors,
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              shape: BoxShape.circle,
            ),
          ),
        ),
        Positioned(
          bottom: 16,
          right: 16,
          child: FloatingActionButton(
            onPressed: onPressed,
            backgroundColor: Colors.transparent, // Make FAB background transparent
            elevation: 0, // Remove shadow
            child: Icon(icon, color: Colors.white), // Set icon color
          ),
        ),
      ],
    );
  }
}
