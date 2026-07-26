import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:movie_app/features/auth/domain/usecases/LogoutUseCase.dart';
import 'package:movie_app/features/profile/domain/usecases/UpdateAvatarUseCase.dart';
import 'package:movie_app/features/profile/domain/usecases/UpdateEmailUseCase.dart';
import 'package:movie_app/features/profile/domain/usecases/UpdateNameUseCase.dart';
import 'package:movie_app/features/profile/presentation/profile/state/ProfileState.dart';

import '../../../domain/usecases/GetMyProfileUseCase.dart';

@injectable
class ProfileManagement extends Cubit<ProfileState> {
  final GetMyProfileUseCase _getMyProfileUseCase;
  final UpdateAvatarUseCase _updateAvatarUseCase;
  final LogoutUseCase _logoutUseCase;
  final UpdateEmailUseCase _updateEmailUseCase;
  final UpdateNameUseCase _updateNameUseCase;

  ProfileManagement(
    this._getMyProfileUseCase,
    this._updateAvatarUseCase,
    this._logoutUseCase,
    this._updateEmailUseCase,
    this._updateNameUseCase,
  ) : super(ProfileState());

  void getMyProfile() async {
    emit(state.copyWith(isLoading: true));
    try {
      final profile = await _getMyProfileUseCase.execute();
      emit(
        state.copyWith(
          name: profile.name,
          email: profile.email,
          avt: profile.avt,
          isLoading: false,
        ),
      );
    } catch (e) {
      emit(state.copyWith(error: e.toString(), isLoading: false));
    }
  }

  void setAvatarFromImagePicker() {
    emit(state.copyWith(avt: null));
  }

  Future<void> updateAvatar(String file) => _updateAvatarUseCase.execute(file);

  Future<void> logout() => _logoutUseCase.execute();

  Future<void> updateName(String name) => _updateNameUseCase.execute(name);

  Future<void> updateEmail(String email) => _updateEmailUseCase.execute(email);
}
