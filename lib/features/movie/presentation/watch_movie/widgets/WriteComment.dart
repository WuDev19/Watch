import 'package:flutter/material.dart';

import '../../../../../core/colors/VColors.dart';

class WriteComment extends StatelessWidget {
  final TextEditingController controller;
  final String? avt;
  final void Function(String comment) onSend;

  const WriteComment({
    super.key,
    required this.controller,
    this.avt,
    required this.onSend,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircleAvatar(
          radius: 18,
          backgroundImage: avt != null ? NetworkImage(avt!) : null,
          backgroundColor: Colors.white24,
          child: avt == null
              ? Icon(Icons.person, color: Colors.white70, size: 20)
              : null,
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.white.withAlpha(20),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: controller,
                    style: const TextStyle(color: Colors.white),
                    decoration: const InputDecoration(
                      hintText: "Write down your feelings...",
                      hintStyle: TextStyle(color: Colors.white38),
                      border: InputBorder.none,
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(
                    Icons.send,
                    color: VColors.colorIcon,
                    size: 20,
                  ),
                  onPressed: () {
                    onSend(controller.text.trim());
                    controller.clear();
                    FocusScope.of(context).unfocus();
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
