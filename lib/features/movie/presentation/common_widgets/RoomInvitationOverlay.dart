import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:movie_app/core/colors/VColors.dart';
import 'package:movie_app/features/movie/domain/models/RoomCreation.dart';
import 'package:movie_app/features/movie/domain/models/RoomInvited.dart';
import 'package:movie_app/features/movie/presentation/shared_management/state/RoomInviteState.dart';
import 'package:movie_app/features/movie/presentation/shared_management/state_management/RoomInvitationManagement.dart';
import 'package:movie_app/utils/MethodHelperUtils.dart';

import '../../../../core/routes/AppRoutes.dart';

//TODO: cập nhật thời gian khi có member join vào
class RoomInvitationOverlay extends StatefulWidget {
  const RoomInvitationOverlay({super.key});

  @override
  State<RoomInvitationOverlay> createState() => _RoomInvitationOverlayState();
}

class _RoomInvitationOverlayState extends State<RoomInvitationOverlay> {
  String? _selectedRoomId;
  bool _isClosed = false;
  final ValueNotifier<bool> _isProcessing = ValueNotifier(false);
  late final RoomInvitationManagement _roomInvitationManagement;

  @override
  void initState() {
    super.initState();
    _roomInvitationManagement = context.read<RoomInvitationManagement>();
    _roomInvitationManagement.watchingRoomInvited();
  }

  @override
  void dispose() {
    _isProcessing.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RoomInvitationManagement, RoomInviteState>(
      builder: (context, state) {
        final invites = state.roomInvited;
        _selectedRoomId ??= invites.isNotEmpty ? invites.first.roomId : null;
        // Nếu invite đang chọn bị xóa (do bị host huỷ chẳng hạn), fallback về đầu list
        if (invites.isNotEmpty &&
            !invites.any((e) => e.roomId == _selectedRoomId)) {
          _selectedRoomId = invites.first.roomId;
        }
        return _isClosed || invites.isEmpty
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
                        color: Colors.black.withAlpha(166),
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
                            color: Colors.white.withAlpha(31),
                            width: 1.5,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withAlpha(153),
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
                              _buildDialogHeader(context, invites),
                              Flexible(
                                child: _buildSplitContent(context, invites),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
      },
      listener: (context, state) {
        setState(() {
          _isClosed = false;
        });
      },
      listenWhen: (previous, current) =>
          current.roomInvited.length > previous.roomInvited.length,
    );
  }

  Widget _buildDialogHeader(BuildContext context, List<RoomInvited> invites) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
      decoration: BoxDecoration(
        color: const Color(0xFF1E2132),
        border: Border(bottom: BorderSide(color: Colors.white.withAlpha(20))),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: VColors.colorIcon.withAlpha(38),
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
              color: VColors.colorIcon.withAlpha(51),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: VColors.colorIcon.withAlpha(102)),
            ),
            child: Text(
              "${invites.length} invitation",
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

  Widget _buildSplitContent(BuildContext context, List<RoomInvited> invites) {
    final mainInvite = invites.firstWhere(
      (element) => element.roomId == _selectedRoomId,
      orElse: () => invites.first,
    );
    final olderInvites = invites
        .where((element) => element.roomId != mainInvite.roomId)
        .toList();
    olderInvites.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    return Row(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          flex: 60,
          child: _buildLeftMainInvitePanel(mainInvite, invites),
        ),
        Container(width: 1, color: Colors.white.withAlpha(20)),
        Expanded(flex: 40, child: _buildRightOlderInvitesPanel(olderInvites)),
      ],
    );
  }

  Widget _buildLeftMainInvitePanel(
    RoomInvited mainInvite,
    List<RoomInvited> invites,
  ) {
    final timeFormatted = MethodHelperUtils.formatTimeAgo(mainInvite.createdAt);
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
                color: Colors.white.withAlpha(102),
                size: 14,
              ),
              const SizedBox(width: 4),
              Text(
                timeFormatted,
                style: TextStyle(
                  color: Colors.white.withAlpha(128),
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
                          color: Colors.white.withAlpha(217),
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
                    color: Colors.white.withAlpha(15),
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(color: Colors.white.withAlpha(26)),
                  ),
                  child: Text(
                    "Room ID: ${mainInvite.roomId}",
                    style: TextStyle(
                      color: Colors.white.withAlpha(179),
                      fontSize: 12,
                      fontFamily: 'monospace',
                    ),
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
                    side: BorderSide(color: Colors.white.withAlpha(51)),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () => _handleDismissInvite(mainInvite, invites),
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
                child: ValueListenableBuilder(
                  valueListenable: _isProcessing,
                  builder: (context, isProcessing, child) {
                    return ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: VColors.colorIcon,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        elevation: 4,
                        shadowColor: VColors.colorIcon.withAlpha(128),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: () => isProcessing
                          ? null
                          : _handleAcceptInvite(mainInvite, invites),
                      icon: const Icon(
                        Icons.play_arrow_rounded,
                        color: Colors.white,
                      ),
                      label: const Text(
                        "Join",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRightOlderInvitesPanel(List<RoomInvited> olderInvites) {
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
                      color: Colors.white.withAlpha(51),
                      size: 36,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "No other pending invitations",
                      style: TextStyle(
                        color: Colors.white.withAlpha(102),
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

  Widget _buildRightInviteCardTile(RoomInvited invite) {
    final timeFormatted = MethodHelperUtils.formatTimeAgo(invite.createdAt);
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
          color: Colors.white.withAlpha(10),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.white.withAlpha(15)),
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
                color: Colors.white.withAlpha(153),
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
                color: Colors.white.withAlpha(15),
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

  void _handleAcceptInvite(
    RoomInvited invite,
    List<RoomInvited> invites,
  ) async {
    if (_isProcessing.value) return;
    _isProcessing.value = true;
    MethodHelperUtils.showSnackBar(
      context,
      "Joining ${invite.roomId} - ${invite.movieName}",
    );
    final success = await _roomInvitationManagement.acceptInvitation(
      invite.roomId,
    );
    if (!mounted) {
      return;
    }
    _isProcessing.value = false;
    if (success) {
      _autoSelectNextAfterRemoval(invite.roomId);
      AppRoutes.routes.push(
        "/watch-together",
        extra: RoomCreation(isHost: false, roomId: invite.roomId),
      );

    } else {
      MethodHelperUtils.showSnackBar(
        context,
        "Join unsuccessfully, please try again",
      );
    }
  }

  void _handleDismissInvite(
    RoomInvited invite,
    List<RoomInvited> invites,
  ) async {
    if (_isProcessing.value) return;
    _isProcessing.value = true;
    final success = await _roomInvitationManagement.skipInvitation(
      invite.roomId,
    );
    if (!mounted) return;
    _isProcessing.value = false;
    if (success) {
      _autoSelectNextAfterRemoval(invite.roomId);
    } else {
      MethodHelperUtils.showSnackBar(
        context,
        "Skip invitation unsuccessfully, please try again",
      );
    }
  }

  void _autoSelectNextAfterRemoval(String removedRoomId) {
    final remaining = _roomInvitationManagement.state.roomInvited;
    setState(() {
      if (remaining.isEmpty) {
        _isClosed = true;
        _selectedRoomId = null;
      } else if (_selectedRoomId == removedRoomId) {
        _selectedRoomId = remaining.first.roomId;
      }
    });
  }
}
