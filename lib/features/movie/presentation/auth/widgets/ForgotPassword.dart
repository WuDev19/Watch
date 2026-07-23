import 'package:flutter/material.dart';
import 'package:movie_app/utils/constants.dart';

import '../../../../../core/colors/VColors.dart';

class ForgotPassword extends StatefulWidget {
  final void Function(String email) onSend;

  const ForgotPassword({super.key, required this.onSend});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(
        Constants.appName,
        style: TextStyle(color: VColors.white),
      ),
      backgroundColor: VColors.blackBackground,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusGeometry.circular(20),
        side: BorderSide(width: 2, color: VColors.colorIcon),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            Constants.forgotPassword,
            style: TextStyle(color: VColors.white),
          ),
          const SizedBox(height: 10),
          TextField(
            controller: _emailController,
            style: TextStyle(color: VColors.white),
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.email, color: VColors.white),
              focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(width: 2, color: VColors.colorIcon),
                borderRadius: BorderRadius.all(Radius.circular(16)),
              ),
              fillColor: Colors.grey[800],
              filled: true,
              border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(16)),
              ),
              labelText: "Enter email",
              labelStyle: TextStyle(color: VColors.white.withAlpha(190)),
            ),
          ),
          const SizedBox(height: 10),
        ],
      ),
      actions: [
        ElevatedButton(
          onPressed: () {
            widget.onSend(_emailController.text.trim());
          },
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadiusGeometry.circular(10),
            ),
            backgroundColor: VColors.colorIcon,
          ),
          child: Text("Send", style: TextStyle(color: VColors.white)),
        ),
      ],
    );
  }
}
