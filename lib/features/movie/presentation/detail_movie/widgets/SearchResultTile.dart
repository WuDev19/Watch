import 'package:flutter/material.dart';

import '../../../../../core/colors/VColors.dart';
import '../../../domain/models/RoomMember.dart';

class SearchResultTile extends StatelessWidget {
  final RoomMember member;
  final bool isAdded;
  final bool disabled;
  final VoidCallback onTap;

  const SearchResultTile({
    required this.member,
    required this.isAdded,
    required this.disabled,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: disabled ? 0.4 : 1,
      child: ListTile(
        onTap: disabled ? null : onTap,
        contentPadding: EdgeInsets.zero,
        leading: CircleAvatar(
          radius: 20,
          backgroundColor: Colors.white24,
          backgroundImage: member.avatarUrl.isNotEmpty
              ? NetworkImage(member.avatarUrl)
              : null,
          child: member.avatarUrl.isEmpty
              ? const Icon(Icons.person, color: Colors.white)
              : null,
        ),
        title: Text(member.name, style: const TextStyle(color: Colors.white)),
        trailing: Icon(
          isAdded ? Icons.check_circle : Icons.add_circle_outline,
          color: isAdded ? VColors.colorIcon : Colors.white54,
        ),
      ),
    );
  }
}
