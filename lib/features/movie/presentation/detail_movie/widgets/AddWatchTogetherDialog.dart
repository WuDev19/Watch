import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/core/colors/VColors.dart';
import 'package:movie_app/features/movie/domain/models/RoomMember.dart';
import 'package:movie_app/features/movie/presentation/common_widgets/ErrorHandleWidget.dart';
import 'package:movie_app/features/movie/presentation/common_widgets/LoadingHandleWidget.dart';
import 'package:movie_app/features/movie/presentation/detail_movie/state/MovieDetailState.dart';
import 'package:movie_app/features/movie/presentation/detail_movie/state/SearchUserState.dart';
import 'package:movie_app/features/movie/presentation/detail_movie/state_management/MovieDetailManagement.dart';

import 'AddedMemberChip.dart';
import 'SearchResultTile.dart';

class AddWatchTogetherDialog extends StatefulWidget {
  const AddWatchTogetherDialog({super.key});

  static const int maxMember = 6;

  @override
  State<AddWatchTogetherDialog> createState() => _AddWatchTogetherDialogState();
}

class _AddWatchTogetherDialogState extends State<AddWatchTogetherDialog> {
  final TextEditingController _searchController = TextEditingController();
  final List<RoomMember> _addedMembers = [];
  late final MovieDetailManagement _movieDetailManagement;
  late final ValueNotifier<List<RoomMember>> _roomMemberListener;

  @override
  void initState() {
    super.initState();
    _movieDetailManagement = context.read<MovieDetailManagement>();
    _roomMemberListener = ValueNotifier(_addedMembers);
  }

  @override
  void dispose() {
    _searchController.dispose();
    _roomMemberListener.dispose();
    super.dispose();
  }

  bool get _isFull => _addedMembers.length >= AddWatchTogetherDialog.maxMember;

  void _addMember(RoomMember member) {
    if (_isFull) return;
    if (_addedMembers.any((e) => e.id == member.id)) return;
    _addedMembers.add(member);
    _roomMemberListener.value = List.from(_addedMembers);
  }

  void _removeMember(RoomMember member) {
    _addedMembers.removeWhere((e) => e.id == member.id);
    _roomMemberListener.value = List.from(_addedMembers);
  }

  @override
  Widget build(BuildContext context) {
    print("revuild");
    return Dialog(
      backgroundColor: VColors.blackBackground,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      insetPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        constraints: const BoxConstraints(maxHeight: 550),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Add people",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                ValueListenableBuilder(
                  valueListenable: _roomMemberListener,
                  builder: (context, value, child) {
                    return Text(
                      "${value.length}/${AddWatchTogetherDialog.maxMember}",
                      style: const TextStyle(
                        color: VColors.colorIcon,
                        fontWeight: FontWeight.bold,
                      ),
                    );
                  },
                ),
              ],
            ),
            const SizedBox(height: 12),
            Container(
              decoration: BoxDecoration(
                color: VColors.greySearch,
                borderRadius: BorderRadius.circular(12),
              ),
              child: TextField(
                controller: _searchController,
                style: const TextStyle(color: Colors.white),
                onSubmitted: (value) =>
                    _movieDetailManagement.searchUser(value),
                decoration: InputDecoration(
                  hintText: "Search by name...",
                  hintStyle: TextStyle(color: Colors.white54),
                  prefixIcon: GestureDetector(
                    onTap: () => _movieDetailManagement.searchUser(
                      _searchController.text.trim(),
                    ),
                    child: Icon(Icons.search, color: Colors.white54),
                  ),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(vertical: 12),
                ),
              ),
            ),
            const SizedBox(height: 12),
            const Text(
              "Added",
              style: TextStyle(color: Colors.white70, fontSize: 13),
            ),
            const SizedBox(height: 8),
            ValueListenableBuilder(
              valueListenable: _roomMemberListener,
              builder: (context, value, child) {
                return Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: _addedMembers
                      .map(
                        (member) => AddedMemberChip(
                          member: member,
                          onRemove: () => _removeMember(member),
                        ),
                      )
                      .toList(),
                );
              },
            ),
            const SizedBox(height: 12),
            const Divider(color: Colors.white24, height: 1),
            const SizedBox(height: 12),
            BlocSelector<
              MovieDetailManagement,
              MovieDetailState,
              SearchUserState
            >(
              selector: (state) => state.searchUserState,
              builder: (context, state) {
                if (state.isLoading) {
                  return const LoadingHandleWidget();
                }
                if (state.error != null) {
                  return ErrorHandleWidget(
                    onTap: () => _movieDetailManagement.searchUser(
                      _searchController.text.trim(),
                    ),
                  );
                }
                if (state.users.isEmpty) {
                  return const Center(
                    child: Text(
                      "No result",
                      style: TextStyle(color: Colors.white),
                    ),
                  );
                }
                final searchResult = state.users
                    .map(
                      (e) => RoomMember(
                        id: e.userId,
                        name: e.name,
                        avatarUrl: e.avt,
                      ),
                    )
                    .toList();
                return Flexible(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: searchResult.length,
                    itemBuilder: (context, index) {
                      final member = searchResult[index];
                      final alreadyAdded = _addedMembers.any(
                        (e) => e.id == member.id,
                      );

                      return SearchResultTile(
                        member: member,
                        isAdded: alreadyAdded,
                        disabled: _isFull && !alreadyAdded,
                        onTap: () => _addMember(member),
                      );
                    },
                  ),
                );
              },
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.of(context).pop(),
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Colors.white24),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      "Cancel",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop(_addedMembers);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: VColors.colorIcon,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      "OK",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
