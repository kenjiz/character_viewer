part of 'search_character_cubit.dart';

class SearchCharacterState extends Equatable {
  final String searchTerm;
  const SearchCharacterState({
    required this.searchTerm,
  });

  factory SearchCharacterState.initial() {
    return const SearchCharacterState(searchTerm: '');
  }

  @override
  List<Object> get props => [searchTerm];

  @override
  bool get stringify => true;

  SearchCharacterState copyWith({
    String? searchTerm,
  }) {
    return SearchCharacterState(
      searchTerm: searchTerm ?? this.searchTerm,
    );
  }
}
