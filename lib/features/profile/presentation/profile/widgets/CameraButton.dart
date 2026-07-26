import 'package:flutter/material.dart';

class CameraButton extends StatelessWidget {
  final VoidCallback onTap;
  final double size;
  final Color? backgroundColor;
  final Color borderColor;
  final Color? iconColor;
  final IconData icon;

  const CameraButton({
    super.key,
    required this.onTap,
    required this.size,
    this.backgroundColor,
    required this.borderColor,
    this.iconColor,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      right: 0,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: backgroundColor,
            shape: BoxShape.circle,
            border: Border.all(color: borderColor, width: 2),
          ),
          child: Icon(icon, size: size, color: iconColor),
        ),
      ),
    );
  }
}
