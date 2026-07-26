import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:movie_app/features/auth/domain/usecases/LoginUseCase.dart';

import '../../../domain/usecases/SendEmailResetPasswordUseCase.dart';
import '../state/AuthState.dart';

@injectable
class LoginCubit extends Cubit<AuthState> {
  final LoginUseCase _loginUseCase;
  final SendEmailResetPasswordUseCase _sendEmailResetPasswordUseCase;

  LoginCubit(this._loginUseCase, this._sendEmailResetPasswordUseCase)
    : super(Initial());

  void login(String email, String password) async {
    try {
      emit(Loading());
      final result = await _loginUseCase.execute(email, password);
      emit(Success(result));
    } catch (e) {
      emit(Error(e.toString()));
    }
  }

  Future<void> sendEmailResetPassword(String email) =>
      _sendEmailResetPasswordUseCase.execute(email);
}
