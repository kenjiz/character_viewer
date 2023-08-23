import 'package:bloc_test/bloc_test.dart';
import 'package:character_viewer/cubit/character/character_cubit.dart';
import 'package:character_viewer/cubit/filtered_character/filtered_character_cubit.dart';
import 'package:character_viewer/cubit/search_character/search_character_cubit.dart';
import 'package:character_viewer/models/character.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockCharacterCubit extends MockCubit<CharacterState>
    implements CharacterCubit {}

class MockSearchCharacterCubit extends MockCubit<SearchCharacterState>
    implements SearchCharacterCubit {}

class MockSearchCharacterState extends Mock implements SearchCharacterState {}

class MockCharacterState extends Mock implements CharacterState {}

class MockCharacter extends Mock implements Character {}

const char1Id = '1';
const char1Name = 'Bart Simpsons';
const char1Description = 'Bart Simpsons description';

const char2Id = '2';
const char2Name = 'Analiza Mendoza';
const char2Description = 'Analiza Mendoza description';

void main() {
  group('FilteredCharacterCubit', () {
    late CharacterCubit characterCubit;
    late SearchCharacterCubit searchCharacterCubit;
    late FilteredCharacterCubit filteredCharacterCubit;

    late Character character1;
    late Character character2;

    setUp(() {
      characterCubit = MockCharacterCubit();
      searchCharacterCubit = MockSearchCharacterCubit();
      character1 = MockCharacter();
      character2 = MockCharacter();

      when(() => characterCubit.fetchCharacters()).thenAnswer((_) async => [
            character1,
            character2,
          ]);

      filteredCharacterCubit = FilteredCharacterCubit(
        characterCubit: characterCubit,
        searchCharacterCubit: searchCharacterCubit,
        // initialCharacters: [
        //   character1,
        //   character2,
        // ],
      );
    });

    test('initial state is correct', () {
      expect(
        filteredCharacterCubit.state,
        const FilteredCharacterState(
          filteredCharacters: [],
        ),
      );
    });

    group('setFilteredCharacters', () {
      searchCharacterCubit = MockSearchCharacterCubit();
      characterCubit = MockCharacterCubit();
      character1 = MockCharacter();
      character2 = MockCharacter();

      setUp(() {
        when(() => searchCharacterCubit.state)
            .thenReturn(SearchCharacterState.initial());
        when(() => characterCubit.state).thenReturn(
          CharacterState(
            status: CharacterStatus.success,
            characters: [character1, character2],
          ),
        );
        when(() => character1.id).thenReturn(char1Id);
        when(() => character1.name).thenReturn(char1Name);
        when(() => character1.description).thenReturn(char1Description);

        when(() => character2.id).thenReturn(char2Id);
        when(() => character2.name).thenReturn(char2Name);
        when(() => character2.description).thenReturn(char2Description);
      });
      blocTest<FilteredCharacterCubit, FilteredCharacterState>(
        'initial list of characters are present',
        build: () => filteredCharacterCubit,
        act: (cubit) => cubit.setFilteredCharacters(),
        verify: (_) => verify(() => characterCubit.stream).called(1),
      );

      blocTest<FilteredCharacterCubit, FilteredCharacterState>(
        'emit characters on success',
        build: () => filteredCharacterCubit,
        act: (cubit) => cubit.setFilteredCharacters(),
        expect: () => <FilteredCharacterState>[
          FilteredCharacterState(filteredCharacters: [character1, character2]),
        ],
      );
      blocTest<FilteredCharacterCubit, FilteredCharacterState>(
        'emit correct character1 on search',
        setUp: () {
          when(() => searchCharacterCubit.state)
              .thenReturn(const SearchCharacterState(searchTerm: 'bart'));
        },
        build: () => filteredCharacterCubit,
        act: (cubit) => cubit.setFilteredCharacters(),
        expect: () => <FilteredCharacterState>[
          FilteredCharacterState(filteredCharacters: [character1]),
        ],
      );

      blocTest<FilteredCharacterCubit, FilteredCharacterState>(
        'emit correct character2 on search',
        setUp: () {
          when(() => searchCharacterCubit.state)
              .thenReturn(const SearchCharacterState(searchTerm: 'analiza'));
        },
        build: () => filteredCharacterCubit,
        act: (cubit) => cubit.setFilteredCharacters(),
        expect: () => <FilteredCharacterState>[
          FilteredCharacterState(filteredCharacters: [character2]),
        ],
      );
    });
  });
}
