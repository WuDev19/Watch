class RoomUpdate {
  String roomId;
  bool? playing;
  num? playbackRate;
  String? movieUrl;
  num? currentTime;

  RoomUpdate({
    required this.roomId,
    this.playing,
    this.playbackRate,
    this.movieUrl,
    this.currentTime,
  });
}
