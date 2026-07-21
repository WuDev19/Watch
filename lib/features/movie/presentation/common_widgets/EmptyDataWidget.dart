import 'package:flutter/material.dart';

import '../../../../utils/constants.dart';

class EmptyDataWidget extends StatelessWidget {
  const EmptyDataWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(Constants.nothing, style: TextStyle(color: Colors.white)),
    );
  }
}
