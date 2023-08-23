part of 'character_cubit.dart';

enum CharacterStatus {
  initial,
  loading,
  success,
  failure,
}

extension CharacterStatusX on CharacterStatus {
  bool get isInitial => this == CharacterStatus.initial;
  bool get isLoading => this == CharacterStatus.loading;
  bool get isSuccess => this == CharacterStatus.success;
  bool get isFailure => this == CharacterStatus.failure;
}

class CharacterState extends Equatable {
  final CharacterStatus status;
  final List<Character> characters;

  const CharacterState({
    required this.status,
    required this.characters,
  });

  factory CharacterState.initial() {
    return const CharacterState(
      characters: [],
      status: CharacterStatus.initial,
    );
  }

  @override
  List<Object> get props => [status, characters];

  @override
  bool get stringify => true;

  CharacterState copyWith({
    CharacterStatus? status,
    List<Character>? characters,
  }) {
    return CharacterState(
      status: status ?? this.status,
      characters: characters ?? this.characters,
    );
  }
}
