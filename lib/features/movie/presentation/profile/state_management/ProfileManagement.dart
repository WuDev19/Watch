import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:movie_app/features/movie/presentation/profile/state/ProfileState.dart';

import '../../../domain/usecases/GetMyProfileUseCase.dart';

@injectable
class ProfileManagement extends Cubit<ProfileState> {
  final GetMyProfileUseCase _getMyProfileUseCase;

  ProfileManagement(this._getMyProfileUseCase) : super(ProfileState());

  void getMyProfile() async {
    emit(state.copyWith(isLoadingProfile: true));
    try {
      final profile = await _getMyProfileUseCase.execute();
      emit(
        state.copyWith(
          name: profile.name,
          email: profile.email,
          avt: profile.avt,
          isLoadingProfile: false,
        ),
      );
    } catch (e) {
      emit(state.copyWith(errorProfile: e.toString(), isLoadingProfile: false));
    }
  }
}
