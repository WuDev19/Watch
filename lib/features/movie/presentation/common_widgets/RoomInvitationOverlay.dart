import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:movie_app/core/colors/VColors.dart';
import 'package:movie_app/features/movie/domain/models/RoomCreation.dart';
import 'package:movie_app/features/movie/domain/models/RoomInvited.dart';

class RoomInviteItemUI {
  final String roomId;
  final String movieName;
  final String hostName;
  final String posterUrl;
  final DateTime createdAt;

  const RoomInviteItemUI({
    required this.roomId,
    required this.movieName,
    required this.hostName,
    required this.posterUrl,
    required this.createdAt,
  });

  factory RoomInviteItemUI.fromRoomInvited(
    RoomInvited invited, {
    int indexOffset = 0,
  }) {
    return RoomInviteItemUI(
      roomId: invited.roomId,
      movieName: invited.movieName,
      hostName:
          "Người dùng #${invited.roomId.substring(0, invited.roomId.length > 4 ? 4 : invited.roomId.length)}",
      posterUrl:
          "https://image.tmdb.org/t/p/w500/8cdWjvZQUExUUTzyp4t6EDMubfO.jpg",
      createdAt: DateTime.now().subtract(
        Duration(minutes: (indexOffset + 1) * 5),
      ),
    );
  }
}

class RoomInvitationOverlay extends StatefulWidget {
  const RoomInvitationOverlay({super.key});

  @override
  State<RoomInvitationOverlay> createState() => _RoomInvitationOverlayState();
}

class _RoomInvitationOverlayState extends State<RoomInvitationOverlay> {
  late List<RoomInviteItemUI> _invites;
  String? _selectedRoomId;
  bool _isClosed = false;

  @override
  void initState() {
    super.initState();
    _initMockData();
  }

  void _initMockData() {
    final now = DateTime.now();
    _invites = [
      RoomInviteItemUI(
        roomId: "ROOM-101",
        movieName: "Deadpool & Wolverine",
        hostName: "Minh Anh (Host)",
        posterUrl:
            "https://image.tmdb.org/t/p/w500/8cdWjvZQUExUUTzyp4t6EDMubfO.jpg",
        createdAt: now.subtract(const Duration(minutes: 2)),
      ),
      RoomInviteItemUI(
        roomId: "ROOM-102",
        movieName: "Spider-Man: Across the Spider-Verse",
        hostName: "Hoàng Nam",
        posterUrl:
            "https://image.tmdb.org/t/p/w500/8Vt6mAwTZWMGGKGfFsvMAtug5Wp.jpg",
        createdAt: now.subtract(const Duration(minutes: 15)),
      ),
      RoomInviteItemUI(
        roomId: "ROOM-103",
        movieName: "Oppenheimer",
        hostName: "Trần Tuấn",
        posterUrl:
            "https://image.tmdb.org/t/p/w500/8Gxv8gSFCU0XGDykEGv7zR1n2ua.jpg",
        createdAt: now.subtract(const Duration(minutes: 42)),
      ),
      RoomInviteItemUI(
        roomId: "ROOM-104",
        movieName: "Dune: Part Two",
        hostName: "Bảo Ngọc",
        posterUrl:
            "https://image.tmdb.org/t/p/w500/1pdfLPoL6VFi8zPjLSpAozch0vI.jpg",
        createdAt: now.subtract(const Duration(hours: 2)),
      ),
    ];

    _invites.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    _selectedRoomId = _invites.isNotEmpty ? _invites.first.roomId : null;
  }

  @override
  Widget build(BuildContext context) {
    final overlayWidget = _isClosed || _invites.isEmpty
        ? const SizedBox.shrink()
        : Material(
            color: Colors.transparent,
            child: Stack(
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _isClosed = true;
                    });
                  },
                  child: Container(
                    color: Colors.black.withOpacity(0.65),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
                      child: const SizedBox.expand(),
                    ),
                  ),
                ),

                Center(
                  child: Container(
                    constraints: const BoxConstraints(
                      maxWidth: 760,
                      maxHeight: 480,
                    ),
                    margin: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 24,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFF161824),
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(
                        color: Colors.white.withOpacity(0.12),
                        width: 1.5,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.6),
                          blurRadius: 32,
                          spreadRadius: 4,
                          offset: const Offset(0, 12),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(24),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // 1. Thanh Tiêu Đề Dialog Header
                          _buildDialogHeader(context),
                          // 2. Nội Dung Chia 2 Phần (Bên trái: Main Invite | Bên phải: Pending List)
                          Flexible(child: _buildSplitContent(context)),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );

    return overlayWidget;
  }

  Widget _buildDialogHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
      decoration: BoxDecoration(
        color: const Color(0xFF1E2132),
        border: Border(
          bottom: BorderSide(color: Colors.white.withOpacity(0.08)),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: VColors.colorIcon.withOpacity(0.15),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.mark_chat_unread_rounded,
              color: VColors.colorIcon,
              size: 20,
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: VColors.colorIcon.withOpacity(0.2),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: VColors.colorIcon.withOpacity(0.4)),
            ),
            child: Text(
              "${_invites.length} invitation",
              style: const TextStyle(
                color: VColors.colorIcon,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          IconButton(
            onPressed: () {
              setState(() {
                _isClosed = true;
              });
            },
            icon: const Icon(
              Icons.close_rounded,
              color: Colors.white60,
              size: 22,
            ),
            splashRadius: 20,
            tooltip: "Đóng",
          ),
        ],
      ),
    );
  }

  Widget _buildSplitContent(BuildContext context) {
    final mainInvite = _invites.firstWhere(
      (element) => element.roomId == _selectedRoomId,
      orElse: () => _invites.first,
    );
    final olderInvites = _invites
        .where((element) => element.roomId != mainInvite.roomId)
        .toList();
    olderInvites.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    return Row(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(flex: 60, child: _buildLeftMainInvitePanel(mainInvite)),
        Container(width: 1, color: Colors.white.withOpacity(0.08)),
        Expanded(flex: 40, child: _buildRightOlderInvitesPanel(olderInvites)),
      ],
    );
  }

  Widget _buildLeftMainInvitePanel(RoomInviteItemUI mainInvite) {
    final timeFormatted = _formatTimeAgo(mainInvite.createdAt);
    return Container(
      padding: const EdgeInsets.all(20),
      color: const Color(0xFF161824),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [VColors.colorIcon, Colors.deepOrange],
              ),
              borderRadius: BorderRadius.circular(6),
            ),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.star_rounded, color: Colors.white, size: 13),
                SizedBox(width: 4),
                Expanded(
                  child: Text(
                    "THE LATEST INVITATION",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 11,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Icon(
                Icons.access_time_rounded,
                color: Colors.white.withOpacity(0.4),
                size: 14,
              ),
              const SizedBox(width: 4),
              Text(
                timeFormatted,
                style: TextStyle(
                  color: Colors.white.withOpacity(0.5),
                  fontSize: 12,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Container(
                    width: 110,
                    height: 155,
                    color: const Color(0xFF25283A),
                    child: Image.network(
                      mainInvite.posterUrl,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          color: const Color(0xFF2A2D40),
                          child: const Center(
                            child: Icon(
                              Icons.movie_rounded,
                              color: VColors.colorIcon,
                              size: 40,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        mainInvite.movieName,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          height: 1.2,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          const CircleAvatar(
                            radius: 10,
                            backgroundColor: VColors.colorIcon,
                            child: Icon(
                              Icons.person,
                              color: Colors.white,
                              size: 12,
                            ),
                          ),
                          const SizedBox(width: 6),
                          Expanded(
                            child: Text(
                              mainInvite.hostName,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.85),
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.06),
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(
                            color: Colors.white.withOpacity(0.1),
                          ),
                        ),
                        child: Text(
                          "Room ID: ${mainInvite.roomId}",
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.7),
                            fontSize: 12,
                            fontFamily: 'monospace',
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    side: BorderSide(color: Colors.white.withOpacity(0.2)),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () => _handleDismissInvite(mainInvite),
                  icon: const Icon(Icons.close_rounded, color: Colors.white70),
                  label: const Text(
                    "Skip",
                    style: TextStyle(
                      color: Colors.white70,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                flex: 1,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: VColors.colorIcon,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    elevation: 4,
                    shadowColor: VColors.colorIcon.withOpacity(0.5),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () => _handleAcceptInvite(mainInvite),
                  icon: const Icon(
                    Icons.play_arrow_rounded,
                    color: Colors.white,
                  ),
                  label: const Text(
                    "Join",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRightOlderInvitesPanel(List<RoomInviteItemUI> olderInvites) {
    return Container(
      color: const Color(0xFF1B1D2C),
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          const Text(
            "Other Invitation",
            style: TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          if (olderInvites.isEmpty)
            Expanded(
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.inbox_rounded,
                      color: Colors.white.withOpacity(0.2),
                      size: 36,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "No other pending invitations",
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.4),
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),
            )
          else
            Expanded(
              child: ListView.separated(
                padding: EdgeInsets.zero,
                itemCount: olderInvites.length,
                separatorBuilder: (context, index) => const SizedBox(height: 8),
                itemBuilder: (context, index) {
                  final invite = olderInvites[index];
                  return _buildRightInviteCardTile(invite);
                },
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildRightInviteCardTile(RoomInviteItemUI invite) {
    final timeFormatted = _formatTimeAgo(invite.createdAt);
    return InkWell(
      onTap: () {
        setState(() {
          _selectedRoomId = invite.roomId;
        });
      },
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.04),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.white.withOpacity(0.06)),
        ),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                invite.posterUrl,
                width: 42,
                height: 58,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    width: 42,
                    height: 58,
                    color: const Color(0xFF2D3045),
                    child: const Icon(
                      Icons.movie,
                      color: Colors.white38,
                      size: 20,
                    ),
                  );
                },
              ),
            ),
            const SizedBox(width: 12),
            Text(
              invite.movieName,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              invite.hostName,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: Colors.white.withOpacity(0.6),
                fontSize: 11,
              ),
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                const Icon(
                  Icons.access_time,
                  color: VColors.colorIcon,
                  size: 11,
                ),
                const SizedBox(width: 3),
                Expanded(
                  child: Text(
                    timeFormatted,
                    style: const TextStyle(
                      color: VColors.colorIcon,
                      fontSize: 10,
                      fontWeight: FontWeight.w500,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            const SizedBox(width: 6),
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.06),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.swap_horiz_rounded,
                color: VColors.colorIcon,
                size: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Xử lý khi nhấn nút "Tham gia"
  void _handleAcceptInvite(RoomInviteItemUI invite) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          "Đang tham gia phòng ${invite.roomId} - ${invite.movieName}",
        ),
        backgroundColor: VColors.colorIcon,
        duration: const Duration(seconds: 2),
      ),
    );

    context.push(
      "/watch-together",
      extra: RoomCreation(isHost: false, roomId: invite.roomId),
    );

    _removeInviteAndAutoSelectNext(invite.roomId);
  }

  /// Xử lý khi nhấn nút "Bỏ qua"
  void _handleDismissInvite(RoomInviteItemUI invite) {
    _removeInviteAndAutoSelectNext(invite.roomId);
  }

  /// Loại bỏ 1 invite khỏi danh sách & tự động chọn lời mời mới nhất tiếp theo
  void _removeInviteAndAutoSelectNext(String roomId) {
    setState(() {
      _invites.removeWhere((e) => e.roomId == roomId);
      if (_invites.isEmpty) {
        _isClosed = true;
        _selectedRoomId = null;
      } else {
        // Sắp xếp lại theo thời gian và chọn lời mời mới nhất làm chính
        _invites.sort((a, b) => b.createdAt.compareTo(a.createdAt));
        _selectedRoomId = _invites.first.roomId;
      }
    });
  }

  String _formatTimeAgo(DateTime dateTime) {
    final diff = DateTime.now().difference(dateTime);
    final diffInSeconds = diff.inSeconds;
    final diffInMinutes = diff.inMinutes;
    final diffInHours = diff.inHours;
    final diffInDays = diff.inDays;
    if (diffInSeconds < 60) {
      return "Just now";
    } else if (diffInMinutes < 60) {
      return diffInMinutes > 1 ? "$diffInMinutes minutes ago" : "1 minute ago";
    } else if (diffInHours < 24) {
      return diffInHours > 1 ? "$diffInHours hours ago" : "1 hour ago";
    } else {
      return diffInDays > 1 ? "$diffInDays days ago" : "1 day ago";
    }
  }
}
