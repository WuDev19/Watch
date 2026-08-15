class MemberRequest {
  final String id;
  final String name;
  final String avatarUrl;

  const MemberRequest({
    required this.id,
    required this.name,
    required this.avatarUrl,
  });

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "avatarUrl": avatarUrl,
  };
}
