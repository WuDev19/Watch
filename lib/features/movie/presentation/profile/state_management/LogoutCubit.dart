import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/features/movie/domain/usecases/LogoutUseCase.dart';
import 'package:movie_app/features/movie/presentation/auth/state/AuthState.dart';

class LogoutCubit extends Cubit<AuthState> {
  final LogoutUseCase _logoutUseCase;

  LogoutCubit(this._logoutUseCase) : super(Initial());

  void logout() async {
    try {
      emit(Loading());
      final result = await _logoutUseCase.execute();
      emit(Success(result));
    } catch (e) {
      emit(Error(e.toString()));
    }
  }
}
