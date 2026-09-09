import 'package:movie_app/features/movie/data/datasources/third-source/dto/request/CreateRoomRequest.dart';
import 'package:movie_app/features/movie/data/datasources/third-source/dto/response/RoomResponse.dart';
import 'package:movie_app/features/movie/data/datasources/third-source/dto/response/RoomUpdateRequest.dart';

abstract class RoomRemoteDataSource {
  Future<void> createRoom(CreateRoomRequest request);

  Future<bool> checkRoom(String roomId);

  Future<Map<String, String>> getHost();

  Stream<RoomResponse?> watching(String roomId);

  Future<void> updateRoom(RoomUpdateRequest request);

  Future<void> deleteRoom(String roomId);

  Stream<List<RoomResponse>> inviteListen();
}
