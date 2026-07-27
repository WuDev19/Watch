import 'package:equatable/equatable.dart';

import 'UpdateEmailState.dart';

class ProfileState extends Equatable {
  final String? name;
  final String? email;
  final String? avt;
  final bool isLoading;
  final String? error;
  final UpdateEmailState updateEmailState;

  const ProfileState({
    this.name,
    this.email,
    this.avt,
    this.isLoading = false,
    this.error,
    this.updateEmailState = const UpdateEmailState(),
  });

  ProfileState copyWith({
    String? name,
    String? email,
    String? avt,
    bool? isLoading,
    String? error,
    UpdateEmailState? updateEmailState,
  }) {
    return ProfileState(
      name: name ?? this.name,
      email: email ?? this.email,
      avt: avt,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      updateEmailState: updateEmailState ?? this.updateEmailState,
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
  ];
}
