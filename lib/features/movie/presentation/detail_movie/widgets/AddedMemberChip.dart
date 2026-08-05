import 'package:flutter/material.dart';

import '../../../../../core/colors/VColors.dart';
import '../../../domain/models/RoomMember.dart';

class AddedMemberChip extends StatelessWidget {
  final RoomMember member;
  final VoidCallback onRemove;

  const AddedMemberChip({required this.member, required this.onRemove});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      decoration: BoxDecoration(
        color: VColors.greySearch,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircleAvatar(
            radius: 14,
            backgroundColor: Colors.white24,
            backgroundImage: member.avatarUrl.isNotEmpty
                ? NetworkImage(member.avatarUrl)
                : null,
            child: member.avatarUrl.isEmpty
                ? const Icon(Icons.person, size: 16, color: Colors.white)
                : null,
          ),
          const SizedBox(width: 6),
          Text(
            member.name,
            style: const TextStyle(color: Colors.white, fontSize: 13),
          ),
          const SizedBox(width: 4),
          GestureDetector(
            onTap: onRemove,
            child: const Icon(Icons.close, size: 16, color: Colors.white70),
          ),
        ],
      ),
    );
  }
}
