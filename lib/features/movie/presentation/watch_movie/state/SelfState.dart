import 'package:equatable/equatable.dart';

class SelfState extends Equatable {
  final String? avt;
  final String? name;

  const SelfState({this.avt, this.name});

  SelfState copyWith({String? avt, String? name}) {
    return SelfState(avt: avt ?? this.avt, name: name ?? this.name);
  }

  @override
  List<Object?> get props => [avt, name];
}
