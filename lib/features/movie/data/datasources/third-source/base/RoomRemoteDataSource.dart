import 'package:movie_app/features/movie/data/datasources/third-source/dto/request/CreateRoomRequest.dart';
import 'package:movie_app/features/movie/data/datasources/third-source/dto/response/RoomResponse.dart';

abstract class RoomRemoteDataSource {
  Future<void> createRoom(CreateRoomRequest request);

  Future<RoomResponse> getRoomDetail(String roomId);

  String getHostId();

  Stream<RoomResponse> watching(String roomId);
}
