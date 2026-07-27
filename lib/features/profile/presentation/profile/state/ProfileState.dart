import 'package:equatable/equatable.dart';
import 'package:movie_app/features/profile/presentation/profile/state/UpdateNameState.dart';

import 'UpdateEmailState.dart';

class ProfileState extends Equatable {
  final String? name;
  final String? email;
  final String? avt;
  final bool isLoading;
  final String? error;
  final UpdateEmailState updateEmailState;
  final UpdateNameState updateNameState;

  const ProfileState({
    this.name,
    this.email,
    this.avt,
    this.isLoading = false,
    this.error,
    this.updateEmailState = const UpdateEmailState(),
    this.updateNameState = const UpdateNameState(),
  });

  ProfileState copyWith({
    String? name,
    String? email,
    String? avt,
    bool? isLoading,
    String? error,
    UpdateEmailState? updateEmailState,
    UpdateNameState? updateNameState,
  }) {
    return ProfileState(
      name: name ?? this.name,
      email: email ?? this.email,
      avt: avt,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      updateEmailState: updateEmailState ?? this.updateEmailState,
      updateNameState: updateNameState ?? this.updateNameState,
    );
  }

  @override
  List<Object?> get props => [
    name,
    email,
    avt,
    isLoading,
    error,
    updateEmailState,
    updateNameState,
  ];
}
