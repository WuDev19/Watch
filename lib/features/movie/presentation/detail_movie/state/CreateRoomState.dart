import 'package:equatable/equatable.dart';

import '../../../domain/models/RoomCreation.dart';

class CreateRoomState extends Equatable {
  final RoomCreation? roomCreation;
  final bool isLoading;
  final String? error;

  const CreateRoomState({
    this.roomCreation,
    this.isLoading = false,
    this.error,
  });

  CreateRoomState copyWith({
    RoomCreation? roomCreation,
    bool? isLoading,
    String? error,
  }) {
    return CreateRoomState(
      roomCreation: roomCreation ?? this.roomCreation,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }

  @override
  List<Object?> get props => [roomCreation, isLoading, error];
}
