import 'package:flutter/material.dart';

import '../../../../../core/colors/VColors.dart';

class OptionTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback? onTap;
  final Color? iconColor;
  final Color? textColor;

  const OptionTile({
    super.key,
    required this.icon,
    required this.title,
    this.onTap,
    this.iconColor,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: Icon(icon, color: iconColor ?? VColors.colorIcon),
      title: Text(
        title,
        style: TextStyle(color: textColor ?? VColors.white, fontSize: 15),
      ),
      trailing: Icon(Icons.chevron_right, color: VColors.white.withAlpha(155)),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    );
  }
}
