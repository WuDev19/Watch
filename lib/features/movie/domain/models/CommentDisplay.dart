class CommentDisplay {
  final String commentId;
  final String? avt;
  final String name;
  final String comment;
  final String time;

  const CommentDisplay({
    required this.commentId,
    this.avt,
    required this.name,
    required this.comment,
    required this.time,
  });
}
