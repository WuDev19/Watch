import 'package:flutter/material.dart';

import '../../../../../core/colors/VColors.dart';

class OptionSheet extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback? onTap;

  const OptionSheet({
    super.key,
    required this.icon,
    required this.title,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white.withAlpha(15),
      borderRadius: BorderRadius.circular(14),
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          child: Row(
            children: [
              Icon(icon, color: VColors.colorIcon),
              const SizedBox(width: 14),
              Text(
                title,
                style: TextStyle(
                  color: VColors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const Spacer(),
              Icon(Icons.chevron_right, color: VColors.white.withAlpha(120)),
            ],
          ),
        ),
      ),
    );
  }
}
