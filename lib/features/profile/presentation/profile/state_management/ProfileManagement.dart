import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:movie_app/features/auth/domain/usecases/LogoutUseCase.dart';
import 'package:movie_app/features/auth/domain/usecases/ReauthenticateUseCase.dart';
import 'package:movie_app/features/profile/domain/usecases/UpdateAvatarUseCase.dart';
import 'package:movie_app/features/profile/domain/usecases/UpdateEmailUseCase.dart';
import 'package:movie_app/features/profile/domain/usecases/UpdateNameUseCase.dart';
import 'package:movie_app/features/profile/presentation/profile/state/ProfileState.dart';

import '../../../domain/usecases/CheckVerifiedNewEmailUseCase.dart';
import '../../../domain/usecases/GetMyProfileUseCase.dart';

@injectable
class ProfileManagement extends Cubit<ProfileState> {
  final GetMyProfileUseCase _getMyProfileUseCase;
  final UpdateAvatarUseCase _updateAvatarUseCase;
  final LogoutUseCase _logoutUseCase;
  final UpdateEmailUseCase _updateEmailUseCase;
  final UpdateNameUseCase _updateNameUseCase;
  final ReauthenticateUseCase _reauthenticateUseCase;
  final CheckVerifiedNewEmailUseCase _checkVerifiedNewEmailUseCase;

  ProfileManagement(
    this._getMyProfileUseCase,
    this._updateAvatarUseCase,
    this._logoutUseCase,
    this._updateEmailUseCase,
    this._updateNameUseCase,
    this._reauthenticateUseCase,
    this._checkVerifiedNewEmailUseCase,
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

  void updateName(String name) async {
    emit(
      state.copyWith(
        avt: state.avt,
        updateNameState: state.updateNameState.copyWith(isLoading: true),
      ),
    );
    try {
      await _updateNameUseCase.execute(name);
      emit(
        state.copyWith(
          avt: state.avt,
          updateNameState: state.updateNameState.copyWith(isLoading: false),
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          avt: state.avt,
          updateNameState: state.updateNameState.copyWith(
            isLoading: false,
            error: e.toString(),
          ),
        ),
      );
    }
  }

  void updateEmail(String email) async {
    emit(
      state.copyWith(
        avt: state.avt,
        updateEmailState: state.updateEmailState.copyWith(isLoading: true),
      ),
    );
    try {
      await _updateEmailUseCase.execute(email);
      emit(
        state.copyWith(
          avt: state.avt,
          updateEmailState: state.updateEmailState.copyWith(isLoading: false),
        ),
      );
    } catch (e) {
      if (e is FirebaseAuthException && e.code == "requires-recent-login") {
        try {
          await _reauthenticateUseCase.execute();
          await _updateEmailUseCase.execute(email);
          emit(
            state.copyWith(
              avt: state.avt,
              updateEmailState: state.updateEmailState.copyWith(
                isLoading: false,
              ),
            ),
          );
        } catch (e) {
          emit(
            state.copyWith(
              avt: state.avt,
              updateEmailState: state.updateEmailState.copyWith(
                isLoading: false,
                error: e.toString(),
              ),
            ),
          );
        }
      } else {
        print("lỗi tiếp ${e.toString()}");
        emit(
          state.copyWith(
            avt: state.avt,
            updateEmailState: state.updateEmailState.copyWith(
              isLoading: false,
              error: e.toString(),
            ),
          ),
        );
      }
    }
  }

  Future<void> checkPendingEmailVerification() =>
      _checkVerifiedNewEmailUseCase.execute();
}
