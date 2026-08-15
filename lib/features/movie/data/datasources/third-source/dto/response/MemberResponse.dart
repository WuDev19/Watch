class MemberResponse {
  final String id;
  final String name;
  final String avatarUrl;

  const MemberResponse({
    required this.id,
    required this.name,
    required this.avatarUrl,
  });

  factory MemberResponse.fromJson(Map<String, dynamic> json) => MemberResponse(
    id: json["id"],
    name: json["name"],
    avatarUrl: json["avatarUrl"],
  );
}
