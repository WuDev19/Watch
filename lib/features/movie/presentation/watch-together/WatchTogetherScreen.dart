import 'package:flutter/material.dart';
import 'package:movie_app/core/colors/VColors.dart';
import 'package:movie_app/features/movie/domain/models/RoomMember.dart';

class WatchTogetherScreen extends StatelessWidget {
  final List<RoomMember> members;

  const WatchTogetherScreen({super.key, required this.members});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: VColors.blackBackground,
      appBar: AppBar(
        backgroundColor: VColors.blackBackground,
        elevation: 0,
        title: const Text(
          "Watch together",
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Column(
        children: [
          // Phần trên: xem phim
          AspectRatio(
            aspectRatio: 16 / 9,
            child: Container(
              width: double.infinity,
              color: Colors.black,
              alignment: Alignment.center,
              child: const Icon(
                Icons.play_circle_outline,
                color: Colors.white54,
                size: 60,
              ),
              // TODO: thay bằng widget video player thật
            ),
          ),

          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                const Icon(Icons.groups, color: VColors.colorIcon, size: 18),
                const SizedBox(width: 6),
                Text(
                  "In room (${members.length})",
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),

          // Phần dưới: danh sách người trong phòng, grid 2 cột
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: members.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                childAspectRatio: 3,
              ),
              itemBuilder: (context, index) {
                final member = members[index];
                return _RoomMemberCard(member: member);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _RoomMemberCard extends StatelessWidget {
  final RoomMember member;

  const _RoomMemberCard({required this.member});

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
