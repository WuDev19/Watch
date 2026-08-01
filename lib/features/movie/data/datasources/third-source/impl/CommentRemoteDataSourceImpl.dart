import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';
import 'package:movie_app/features/movie/data/datasources/third-source/base/CommentRemoteDataSource.dart';
import 'package:movie_app/features/movie/data/datasources/third-source/dto/request/CommentRequest.dart';
import 'package:movie_app/features/movie/data/datasources/third-source/dto/response/CommentResponse.dart';

@LazySingleton(as: CommentRemoteDataSource)
class CommentRemoteDataSourceImpl implements CommentRemoteDataSource {
  final FirebaseFirestore _firebaseFirestore;
  final FirebaseAuth _firebaseAuth;

  CommentRemoteDataSourceImpl(this._firebaseFirestore, this._firebaseAuth);

  @override
  Future<void> postComment(CommentRequest request) {
    final comment = _firebaseFirestore.collection('comments').doc();
    return _firebaseFirestore.collection('comments').doc(comment.id).set({
      'commentId': comment.id,
      'avt': request.avt,
      'name': request.name,
      'comment': request.comment,
      'userId': _firebaseAuth.currentUser!.uid,
      'createdAt': Timestamp.now(),
    });
  }

  @override
  Future<void> deleteComment(String id) {
    return _firebaseFirestore.collection('comments').doc(id).delete();
  }

  @override
  Future<List<CommentResponse>> getComments(String movieSlug) async {
    final response = await _firebaseFirestore
        .collection('comments')
        .where('movieSlug', isEqualTo: movieSlug)
        .orderBy('createdAt', descending: true)
        .get();
    final comments = response.docs.map((e) {
      return CommentResponse(
        commentId: e.get('commentId'),
        userId: e.get('userId'),
        avt: e.get('avt'),
        name: e.get('name'),
        comment: e.get('comment'),
        movieSlug: e.get('movieSlug'),
        createdAt: e.get('createdAt'),
      );
    }).toList();
    final userId = _firebaseAuth.currentUser!.uid;
    final myComments = comments
        .where((element) => element.userId == userId)
        .toList();
    myComments.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    comments.removeWhere((element) => element.userId == userId);
    if (myComments.isNotEmpty) {
      for (int i = 0; i < myComments.length; i++) {
        comments.insert(i, myComments[i]);
      }
    }
    return comments;
  }
}
