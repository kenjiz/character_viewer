part of 'filtered_character_cubit.dart';

class FilteredCharacterState extends Equatable {
  final List<Character> filteredCharacters;

  const FilteredCharacterState({
    required this.filteredCharacters,
  });

  factory FilteredCharacterState.initial() {
    return const FilteredCharacterState(filteredCharacters: []);
  }

  @override
  List<Object> get props => [filteredCharacters];

  @override
  bool get stringify => true;

  FilteredCharacterState copyWith({
    List<Character>? filteredCharacters,
  }) {
    return FilteredCharacterState(
      filteredCharacters: filteredCharacters ?? this.filteredCharacters,
    );
  }
}
