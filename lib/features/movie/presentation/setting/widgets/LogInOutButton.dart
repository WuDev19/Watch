import 'package:flutter/material.dart';

import '../../../../../core/colors/VColors.dart';

class LogInOutButton extends StatelessWidget {
  final String text;
  final void Function() onDo;

  const LogInOutButton({super.key, required this.text, required this.onDo});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: AlignmentGeometry.topCenter,
      child: ElevatedButton(
        onPressed: () {
          onDo();
        },
        style: ElevatedButton.styleFrom(
          elevation: 8,
          backgroundColor: VColors.colorIcon,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadiusGeometry.circular(10),
            side: BorderSide(width: 2, color: VColors.white),
          ),
        ),
        child: Text(text, style: TextStyle(color: VColors.white)),
      ),
    );
  }
}
