import 'package:equatable/equatable.dart';

class ProfileState extends Equatable {
  final String? name;
  final String? email;
  final String? avt;
  final bool isLoadingProfile;
  final String? errorProfile;

  const ProfileState({
    this.name,
    this.email,
    this.avt,
    this.isLoadingProfile = false,
    this.errorProfile,
  });

  ProfileState copyWith({
    String? name,
    String? email,
    String? avt,
    bool? isLoadingProfile,
    String? errorProfile,
  }) {
    return ProfileState(
      name: name ?? this.name,
      email: email ?? this.email,
      avt: avt ?? this.avt,
      isLoadingProfile: isLoadingProfile ?? this.isLoadingProfile,
      errorProfile: errorProfile ?? this.errorProfile,
    );
  }

  @override
  List<Object?> get props => [name, email, avt, isLoadingProfile, errorProfile];
}
