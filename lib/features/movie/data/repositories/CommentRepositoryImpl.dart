import 'dart:math';

import 'package:injectable/injectable.dart';
import 'package:movie_app/features/movie/domain/models/Comment.dart';
import 'package:movie_app/features/movie/domain/models/CommentTotal.dart';
import 'package:movie_app/features/movie/domain/repositories/CommentRepository.dart';

import '../datasources/third-source/base/CommentRemoteDataSource.dart';
import '../datasources/third-source/mapper/CommentMapper.dart';

@LazySingleton(as: CommentRepository)
class CommentRepositoryImpl implements CommentRepository {
  final CommentRemoteDataSource _commentRemoteDataSource;

  CommentRepositoryImpl(this._commentRemoteDataSource);

  @override
  Future<void> postComment(Comment comment) {
    final request = CommentMapper.mapToCommentRequest(comment);
    return _commentRemoteDataSource.postComment(request);
  }

  @override
  Future<void> deleteComment(String id) =>
      _commentRemoteDataSource.deleteComment(id);

  @override
  Future<CommentTotal> getComments(String movieSlug) async {
    final response = await _commentRemoteDataSource.getComments(movieSlug);
    final result = response.sublist(0, min(24, response.length)).map((e) {
      return CommentMapper.mapToCommentDisplay(e);
    }).toList();
    return CommentMapper.mapToCommentTotal(result, response.length);
  }
}
