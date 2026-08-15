import 'package:movie_app/features/movie/data/datasources/third-source/dto/request/CreateRoomRequest.dart';
import 'package:movie_app/features/movie/data/datasources/third-source/dto/response/RoomResponse.dart';
import 'package:movie_app/features/movie/domain/models/RoomMember.dart';
import 'package:movie_app/features/movie/domain/models/RoomWatching.dart';

import '../../../../domain/models/RoomCreation.dart';
import '../dto/request/MemberRequest.dart';
import '../dto/response/MemberResponse.dart';

class RoomMapper {
  RoomMapper._();

  static CreateRoomRequest mapToCreateRoomRequest(
    RoomCreation roomCreate,
    String hostId,
  ) {
    final members = roomCreate.members!.isEmpty
        ? <MemberRequest>[]
        : roomCreate.members!
              .map(
                (e) => MemberRequest(
                  id: e.id,
                  name: e.name,
                  avatarUrl: e.avatarUrl,
                ),
              )
              .toList();
    return CreateRoomRequest(
      roomId: roomCreate.roomId,
      isPlaying: false,
      playbackRate: 1,
      movieUrl: roomCreate.combine!.movieWatch.currentEpisode.linkM3U8,
      currentTime: 0,
      hostId: hostId,
      members: members,
    );
  }

  static RoomWatching mapToRoomWatching(RoomResponse roomResponse) {
    return RoomWatching(
      roomId: roomResponse.roomId,
      isPlaying: roomResponse.isPlaying,
      playbackRate: roomResponse.playbackRate,
      movieUrl: roomResponse.movieUrl,
      currentTime: roomResponse.currentTime,
      hostId: roomResponse.hostId,
      members: roomResponse.members.map(mapToRoomMember).toList(),
    );
  }

  static RoomMember mapToRoomMember(MemberResponse memberResponse) {
    return RoomMember(
      id: memberResponse.id,
      name: memberResponse.name,
      avatarUrl: memberResponse.avatarUrl,
    );
  }
}
