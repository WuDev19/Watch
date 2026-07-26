import 'package:equatable/equatable.dart';

class ProfileState extends Equatable {
  final String? name;
  final String? email;
  final String? avt;
  final bool isLoading;
  final String? error;

  const ProfileState({
    this.name,
    this.email,
    this.avt,
    this.isLoading = false,
    this.error,
  });

  ProfileState copyWith({
    String? name,
    String? email,
    String? avt,
    bool? isLoading,
    String? error,
  }) {
    return ProfileState(
      name: name ?? this.name,
      email: email ?? this.email,
      avt: avt,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [name, email, avt, isLoading, error];
}
