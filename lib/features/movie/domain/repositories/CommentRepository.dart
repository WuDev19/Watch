import '../models/Comment.dart';
import '../models/CommentTotal.dart';

abstract class CommentRepository {
  Future<void> postComment(Comment comment);

  Future<void> deleteComment(String id);

  Future<CommentTotal> getComments(String movieSlug);
}
