import 'package:equatable/equatable.dart';

class UpdateNameState extends Equatable {
  final bool isLoading;
  final String? error;

  const UpdateNameState({this.isLoading = false, this.error});

  UpdateNameState copyWith({bool? isLoading, String? error}) {
    return UpdateNameState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [isLoading, error];
}
