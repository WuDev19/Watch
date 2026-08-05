import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/core/colors/VColors.dart';
import 'package:movie_app/features/movie/domain/models/RoomMember.dart';
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
  late final MovieDetailManagement _movieDetailManagement;
  final List<RoomMember> _searchResult = const [
    RoomMember(id: "1", name: "Minh Anh", avatarUrl: ""),
    RoomMember(id: "2", name: "Quang Huy", avatarUrl: ""),
    RoomMember(id: "3", name: "Thu Trang", avatarUrl: ""),
    RoomMember(id: "4", name: "Bảo Ngọc", avatarUrl: ""),
  ];

  final List<RoomMember> _addedMembers = [];

  @override
  void initState() {
    super.initState();
    _movieDetailManagement = context.read<MovieDetailManagement>();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  bool get _isFull => _addedMembers.length >= AddWatchTogetherDialog.maxMember;

  void _addMember(RoomMember member) {
    if (_isFull) return;
    if (_addedMembers.any((e) => e.id == member.id)) return;
    setState(() {
      _addedMembers.add(member);
    });
  }

  void _removeMember(RoomMember member) {
    setState(() {
      _addedMembers.removeWhere((e) => e.id == member.id);
    });
  }

  @override
  Widget build(BuildContext context) {
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
                Text(
                  "${_addedMembers.length}/${AddWatchTogetherDialog.maxMember}",
                  style: const TextStyle(
                    color: VColors.colorIcon,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),

            // Thanh tìm kiếm
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
                decoration: const InputDecoration(
                  hintText: "Search by name...",
                  hintStyle: TextStyle(color: Colors.white54),
                  prefixIcon: Icon(Icons.search, color: Colors.white54),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(vertical: 12),
                ),
              ),
            ),
            const SizedBox(height: 12),

            // Danh sách người đã thêm
            if (_addedMembers.isNotEmpty) ...[
              const Text(
                "Added",
                style: TextStyle(color: Colors.white70, fontSize: 13),
              ),
              const SizedBox(height: 8),
              Wrap(
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
              ),
              const SizedBox(height: 12),
              const Divider(color: Colors.white24, height: 1),
              const SizedBox(height: 12),
            ],

            // Danh sách kết quả tìm kiếm
            Flexible(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: _searchResult.length,
                itemBuilder: (context, index) {
                  final member = _searchResult[index];
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
                      // TODO: trả về danh sách _addedMembers cho màn cha xử lý logic
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
