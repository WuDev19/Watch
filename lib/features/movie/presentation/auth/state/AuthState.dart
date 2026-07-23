sealed class AuthState {}

final class Initial extends AuthState {}

final class Loading extends AuthState {}

final class Success<T> extends AuthState {
  final T data;

  Success(this.data);
}

final class Error extends AuthState {
  final String message;

  Error(this.message);
}
