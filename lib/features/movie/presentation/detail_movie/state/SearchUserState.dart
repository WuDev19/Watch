import 'package:equatable/equatable.dart';
import 'package:movie_app/features/movie/domain/models/UserSearch.dart';

class SearchUserState extends Equatable {
  final List<UserSearch> users;
  final bool isLoading;
  final String? error;

  const SearchUserState({
    this.users = const [],
    this.isLoading = false,
    this.error,
  });

  SearchUserState copyWith({
    List<UserSearch>? users,
    bool? isLoading,
    String? error,
  }) {
    return SearchUserState(
      users: users ?? this.users,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }

  List<Object?> get props => [users, isLoading, error];
}
