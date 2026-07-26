import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:movie_app/features/auth/domain/models/SignUpModel.dart';
import 'package:movie_app/features/auth/presentation/auth/state/AuthState.dart';

import '../../../domain/usecases/SignUpUseCase.dart';

@injectable
class SignUpCubit extends Cubit<AuthState> {
  final SignUpUseCase _signUpUseCase;

  SignUpCubit(this._signUpUseCase) : super(Initial());

  void signUp({
    required String name,
    required String email,
    required String password,
  }) {
    emit(Loading());
    _signUpUseCase
        .signUp(SignUpModel(email, password, name, true))
        .then((value) {
          emit(Success(value));
        })
        .catchError((e) {
          emit(Error(e.toString()));
        });
  }
}
