import 'package:injectable/injectable.dart';

import '../repositories/CommentRepository.dart';

@lazySingleton
class DeleteCommentUseCase {
  final CommentRepository _commentRepository;

  DeleteCommentUseCase(this._commentRepository);

  Future<void> execute(String id) => _commentRepository.deleteComment(id);
}
