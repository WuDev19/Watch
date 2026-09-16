class RoomInvited {
  final String roomId;
  final String movieName;
  final String hostName;
  final String posterUrl;
  final DateTime createdAt;

  RoomInvited({
    required this.roomId,
    required this.movieName,
    required this.hostName,
    required this.posterUrl,
    required this.createdAt,
  });
}
