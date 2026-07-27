import 'package:equatable/equatable.dart';

class UpdateEmailState extends Equatable {
  final bool isLoading;
  final String? error;

  const UpdateEmailState({this.isLoading = false, this.error});

  UpdateEmailState copyWith({bool? isLoading, String? error}) {
    return UpdateEmailState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [isLoading, error];
}
