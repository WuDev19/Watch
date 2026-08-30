class RoomUpdateRequest {
  String roomId;
  bool? playing;
  num? playbackRate;
  String? movieUrl;
  num? currentTime;

  RoomUpdateRequest({
    required this.roomId,
    this.playing,
    this.playbackRate,
    this.movieUrl,
    this.currentTime,
  });
}
