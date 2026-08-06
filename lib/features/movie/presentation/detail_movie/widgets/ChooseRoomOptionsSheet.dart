import 'package:flutter/material.dart';

import '../../../../../core/colors/VColors.dart';
import '../../../../profile/presentation/profile/widgets/OptionSheet.dart';

enum RoomType { create, join }

class ChooseRoomOptionsSheet extends StatelessWidget {
  final void Function(RoomType option) onSelected;

  const ChooseRoomOptionsSheet({super.key, required this.onSelected});

  static Future<void> show(
    BuildContext context, {
    required void Function(RoomType option) onSelected,
  }) {
    return showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (_) => ChooseRoomOptionsSheet(onSelected: onSelected),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      decoration: BoxDecoration(
        color: VColors.blackBackground,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        border: Border.all(color: Colors.white24),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 40,
            height: 4,
            margin: const EdgeInsets.only(bottom: 16),
            decoration: BoxDecoration(
              color: Colors.white24,
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          Text(
            "Watch Together",
            style: TextStyle(
              color: VColors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          OptionSheet(
            icon: Icons.home_outlined,
            title: "Create",
            onTap: () {
              onSelected(RoomType.create);
            },
          ),
          const SizedBox(height: 8),
          OptionSheet(
            icon: Icons.email_outlined,
            title: "Join",
            onTap: () {
              onSelected(RoomType.join);
            },
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}
