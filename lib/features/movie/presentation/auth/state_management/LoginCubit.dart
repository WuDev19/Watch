import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:movie_app/features/movie/domain/usecases/LoginUseCase.dart';

import '../state/AuthState.dart';

@injectable
class LoginCubit extends Cubit<AuthState> {
  final LoginUseCase _loginUseCase;

  LoginCubit(this._loginUseCase) : super(Initial());

  void login(String email, String password) async {
    try {
      emit(Loading());
      final result = await _loginUseCase.execute(email, password);
      emit(Success(result));
    } catch (e) {
      emit(Error(e.toString()));
    }
  }

}
