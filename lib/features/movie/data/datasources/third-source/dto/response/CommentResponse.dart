import 'package:cloud_firestore/cloud_firestore.dart';

class CommentResponse {
  final String commentId;
  final String userId;
  final String avt;
  final String name;
  final String comment;
  final String movieSlug;
  final Timestamp createdAt;

  const CommentResponse({
    required this.commentId,
    required this.userId,
    required this.avt,
    required this.name,
    required this.comment,
    required this.movieSlug,
    required this.createdAt,
  });
}
