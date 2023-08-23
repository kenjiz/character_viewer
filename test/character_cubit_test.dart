import 'package:bloc_test/bloc_test.dart';
import 'package:character_viewer/cubit/character/character_cubit.dart';
import 'package:character_viewer/models/character.dart';
import 'package:character_viewer/repositories/character_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockCharacterRepository extends Mock implements CharacterRepository {}

class MockCharacter extends Mock implements Character {}

const characterName = 'Bart Simpsons';
const characterDescription = 'Some description';
const characterId = '1';

void main() {
  group('CharacterCubit', () {
    late CharacterRepository characterRepository;
    late CharacterCubit characterCubit;
    late Character character;

    setUp(() async {
      character = MockCharacter();
      characterRepository = MockCharacterRepository();
      when(() => character.name).thenReturn(characterName);
      when(() => character.id).thenReturn(characterId);
      when(() => character.description).thenReturn(characterDescription);
      when(() => characterRepository.getCharacters())
          .thenAnswer((_) async => [character]);
      characterCubit = CharacterCubit(characterRepository);
    });

    test('initial state is correct', () {
      final characterCubit = CharacterCubit(characterRepository);
      expect(characterCubit.state, CharacterState.initial());
    });

    group('fetchCharacter', () {
      blocTest<CharacterCubit, CharacterState>(
        'emits loading, success on fetch',
        build: () => characterCubit,
        act: (cubit) => cubit.fetchCharacters(),
        expect: () => <dynamic>[
          const CharacterState(
            status: CharacterStatus.loading,
            characters: [],
          ),
          isA<CharacterState>()
              .having(
            (c) => c.status,
            'status',
            CharacterStatus.success,
          )
              .having(
            (c) => c.characters,
            'characters',
            [character],
          ).having(
            (c) => c.characters.first,
            '',
            character,
          ),
        ],
      );

      blocTest<CharacterCubit, CharacterState>(
        'emits failure on Exception',
        setUp: () {
          when(() => characterRepository.getCharacters())
              .thenThrow(Exception('Exception!'));
        },
        build: () => characterCubit,
        act: (cubit) => cubit.fetchCharacters(),
        expect: () => <CharacterState>[
          const CharacterState(
            status: CharacterStatus.loading,
            characters: [],
          ),
          const CharacterState(
            status: CharacterStatus.failure,
            characters: [],
          ),
        ],
      );
    });

    group('refresh', () {
      blocTest<CharacterCubit, CharacterState>(
          'emits nothing when CharacterStatus.success',
          build: () => characterCubit,
          seed: () => CharacterState(
                status: CharacterStatus.success,
                characters: [character],
              ),
          act: (cubit) => cubit.refresh(),
          expect: () => <CharacterState>[],
          verify: (_) => verifyNever(
                () => characterRepository.getCharacters(),
              ));

      blocTest<CharacterCubit, CharacterState>(
        'invokes getCharacters with success',
        build: () => characterCubit,
        seed: () => CharacterState(
          status: CharacterStatus.initial,
          characters: [character],
        ),
        act: (cubit) => cubit.refresh(),
        verify: (_) =>
            verify(() => characterRepository.getCharacters()).called(1),
      );
    });
  });
}
