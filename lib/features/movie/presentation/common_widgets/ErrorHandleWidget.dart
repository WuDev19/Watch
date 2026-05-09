import 'package:flutter/material.dart';

import '../../../../core/colors/VColors.dart';
import '../../../../utils/constants.dart';

class ErrorHandleWidget extends StatelessWidget {
  final Function() onTap;

  const ErrorHandleWidget({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(backgroundColor: VColors.colorIcon),
        onPressed: () {
          onTap();
        },
        child: Text(Constants.retry, style: TextStyle(color: Colors.white)),
      ),
    );
  }
}
