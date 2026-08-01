class CommentRequest {
  final String? avt;
  final String name;
  final String comment;
  final String movieSlug;

  const CommentRequest({
    this.avt,
    required this.name,
    required this.comment,
    required this.movieSlug,
  });
}
