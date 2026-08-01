import 'package:injectable/injectable.dart';

import '../models/Comment.dart';
import '../repositories/CommentRepository.dart';

@lazySingleton
class PostCommentUseCase {
  final CommentRepository _commentRepository;

  PostCommentUseCase(this._commentRepository);

  Future<void> execute(Comment comment) =>
      _commentRepository.postComment(comment);
}
