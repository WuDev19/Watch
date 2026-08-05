import 'package:flutter/material.dart';

import '../../../../../core/colors/VColors.dart';
import '../../../domain/models/RoomMember.dart';

class RoomMemberCard extends StatelessWidget {
  final RoomMember member;

  const RoomMemberCard({required this.member});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: VColors.greySearch,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 18,
            backgroundColor: Colors.white24,
            backgroundImage: member.avatarUrl.isNotEmpty
                ? NetworkImage(member.avatarUrl)
                : null,
            child: member.avatarUrl.isEmpty
                ? const Icon(Icons.person, color: Colors.white, size: 18)
                : null,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              member.name,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
