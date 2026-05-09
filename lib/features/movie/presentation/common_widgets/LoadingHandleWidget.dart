import 'package:flutter/material.dart';

import '../../../../core/colors/VColors.dart';

class LoadingHandleWidget extends StatelessWidget {
  const LoadingHandleWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        color: VColors.colorIcon,
      ),
    );
  }
}
