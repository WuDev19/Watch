import 'package:injectable/injectable.dart';

import '../models/CommentTotal.dart';
import '../repositories/CommentRepository.dart';

@lazySingleton
class GetCommentOfMovieUseCase {
  final CommentRepository _commentRepository;

  GetCommentOfMovieUseCase(this._commentRepository);

  Future<CommentTotal> execute(String movieSlug) =>
      _commentRepository.getComments(movieSlug);
}
