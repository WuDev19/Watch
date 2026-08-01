import 'package:movie_app/features/movie/data/datasources/third-source/dto/request/CommentRequest.dart';

import '../dto/response/CommentResponse.dart';

abstract class CommentRemoteDataSource {
  Future<void> postComment(CommentRequest request);

  Future<void> deleteComment(String id);

  Future<List<CommentResponse>> getComments(String movieSlug);
}
