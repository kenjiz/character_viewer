import 'package:bloc_test/bloc_test.dart';
import 'package:character_viewer/cubit/search_character/search_character_cubit.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('searchCharacterCubit', () {
    test('initial state is correct', () {
      final searchCharacterCubit = SearchCharacterCubit();
      expect(searchCharacterCubit.state, SearchCharacterState.initial());
    });

    blocTest<SearchCharacterCubit, SearchCharacterState>(
      'emits correct state on setSearchTerm',
      build: () => SearchCharacterCubit(),
      act: (cubit) => cubit.setSearchTerm('searchKey'),
      expect: () => <SearchCharacterState>[
        const SearchCharacterState(searchTerm: 'searchKey'),
      ],
    );
  });
}
