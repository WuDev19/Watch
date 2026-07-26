import 'package:flutter/material.dart';

import '../../../../../core/colors/VColors.dart';

class LogInOutButton extends StatelessWidget {
  final String text;
  final Icon icon;
  final Color borderColor;
  final Color textColor;
  final void Function() onDo;

  const LogInOutButton({
    super.key,
    required this.text,
    required this.onDo,
    required this.icon,
    required this.borderColor,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: AlignmentGeometry.topCenter,
      child: ElevatedButton.icon(
        onPressed: () {
          onDo();
        },
        style: ElevatedButton.styleFrom(
          elevation: 8,
          backgroundColor: VColors.blackBackground,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadiusGeometry.circular(10),
            side: BorderSide(width: 2, color: borderColor),
          ),
        ),
        label: Text(text, style: TextStyle(color: textColor)),
        icon: icon,
      ),
    );
  }
}
