import 'package:movie_app/features/movie/domain/models/CommentDisplay.dart';

class CommentTotal {
  final List<CommentDisplay> comments;
  final String others;

  const CommentTotal({required this.comments, required this.others});
}
