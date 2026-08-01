import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:movie_app/features/movie/data/datasources/third-source/dto/request/CommentRequest.dart';
import 'package:movie_app/features/movie/domain/models/CommentDisplay.dart';
import 'package:movie_app/features/movie/domain/models/CommentTotal.dart';

import '../../../../domain/models/Comment.dart';
import '../dto/response/CommentResponse.dart';

class CommentMapper {
  CommentMapper._();

  static CommentRequest mapToCommentRequest(Comment comment) => CommentRequest(
    avt: comment.avt,
    name: comment.name,
    comment: comment.comment,
    movieSlug: comment.movieSlug,
  );

  static CommentDisplay mapToCommentDisplay(CommentResponse response) {
    final diff = Duration(
      seconds: Timestamp.now().seconds - response.createdAt.seconds,
    );
    String timeAgo;
    if (diff.inMinutes < 1) {
      timeAgo = '${diff.inSeconds} seconds ago';
    } else if (diff.inHours < 1) {
      timeAgo = '${diff.inMinutes} minutes ago';
    } else if (diff.inDays < 1) {
      timeAgo = '${diff.inHours} hours ago';
    } else {
      timeAgo = '${diff.inDays} days ago';
    }
    return CommentDisplay(
      commentId: response.commentId,
      avt: response.avt,
      name: response.name,
      comment: response.comment,
      time: timeAgo,
    );
  }

  static CommentTotal mapToCommentTotal(
    List<CommentDisplay> comments,
    int total,
  ) {
    final othersText = total > 24 ? 'and ${total - 24} others' : '';
    return CommentTotal(comments: comments, others: othersText);
  }
}
