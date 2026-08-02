import 'package:flutter/material.dart';
import 'package:movie_app/features/movie/domain/models/CommentDisplay.dart';

class CommentItem extends StatelessWidget {
  final CommentDisplay commentDisplay;
  final void Function(String commentId) onDelete;

  const CommentItem({
    super.key,
    required this.commentDisplay,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final avt = commentDisplay.avt;
    final name = commentDisplay.name;
    final time = commentDisplay.time;
    final comment = commentDisplay.comment;
    final commentId = commentDisplay.commentId;
    return InkWell(
      onLongPress: () => onDelete(commentId),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 14),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 18,
              backgroundColor: Colors.white24,
              backgroundImage: avt != null ? NetworkImage(avt) : null,
              child: avt == null
                  ? Icon(Icons.person, color: Colors.white70, size: 20)
                  : null,
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        name,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 13,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        time,
                        style: const TextStyle(
                          color: Colors.white38,
                          fontSize: 11,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    comment,
                    style: const TextStyle(color: Colors.white70, fontSize: 13),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
