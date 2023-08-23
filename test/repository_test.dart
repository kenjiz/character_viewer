import 'package:character_api/character_api.dart';
import 'package:character_viewer/models/character.dart';
import 'package:character_viewer/models/character_type.dart';
import 'package:character_viewer/repositories/character_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockCharacterAPIClient extends Mock implements CharacterAPIClient {}

class MockCharacter extends Mock implements CharacterAPIModel {}

void main() {
  group('The Simpsons CharacterRepository', () {
    late CharacterAPIClient characterAPIClient;
    late CharacterRepository characterRepository;

    setUpAll(() {
      registerFallbackValue(CharacterType.simpsons);
    });

    setUp(() {
      characterAPIClient = MockCharacterAPIClient();
      characterRepository = CharacterRepository(
        characterAPIClient: characterAPIClient,
        characterType: CharacterType.simpsons,
      );
    });

    group('constructor', () {
      test('instantiates internal character api client when not injected', () {
        expect(CharacterRepository(), isNotNull);
      });
    });

    group('getCharacters', () {
      const id = '1';
      const name = 'Bart Simpsons';
      const description = 'A great character';
      const imageUrl = '/i/12345.png';

      const CharacterType apiType = CharacterType.simpsons;
      final character = MockCharacter();

      test('calls getCharacters with correct CharacterAPIType', () async {
        try {
          await characterRepository.getCharacters();
        } catch (_) {}
        verify(() =>
                characterAPIClient.getCharacters(apiType: apiType.queryString))
            .called(1);
      });

      test('returns correct character data on success', () async {
        when(() => character.id).thenReturn(id);
        when(() => character.name).thenReturn(name);
        when(() => character.description).thenReturn(description);
        when(() => character.imageUrl).thenReturn(imageUrl);
        when(() => characterAPIClient.getCharacters(
                apiType: any(named: 'apiType')))
            .thenAnswer((_) async => [character]);

        final actual = await characterRepository.getCharacters();
        expect(actual, [
          const Character(
            id: id,
            name: name,
            description: description,
            imageUrl: 'https://duckduckgo.com$imageUrl',
          ),
        ]);
      });
    });
  });

  group('The Wire CharacterRepository', () {
    late CharacterAPIClient characterAPIClient;
    late CharacterRepository characterRepository;

    setUpAll(() {
      registerFallbackValue(CharacterType.theWire);
    });

    setUp(() {
      characterAPIClient = MockCharacterAPIClient();
      characterRepository = CharacterRepository(
        characterAPIClient: characterAPIClient,
        characterType: CharacterType.theWire,
      );
    });

    group('constructor', () {
      test('instantiates internal character api client when not injected', () {
        expect(CharacterRepository(), isNotNull);
      });
    });

    group('getCharacters', () {
      const id = '1';
      const name = 'Alma Gutierrez';
      const description = 'A great character';
      const imageUrl = '/i/12345.png';

      const CharacterType apiType = CharacterType.theWire;
      final character = MockCharacter();

      test('calls getCharacters with correct CharacterAPIType', () async {
        try {
          await characterRepository.getCharacters();
        } catch (_) {}
        verify(() =>
                characterAPIClient.getCharacters(apiType: apiType.queryString))
            .called(1);
      });

      test('returns correct character data on success', () async {
        when(() => character.id).thenReturn(id);
        when(() => character.name).thenReturn(name);
        when(() => character.description).thenReturn(description);
        when(() => character.imageUrl).thenReturn(imageUrl);
        when(() => characterAPIClient.getCharacters(
                apiType: any(named: 'apiType')))
            .thenAnswer((_) async => [character]);

        final actual = await characterRepository.getCharacters();
        expect(actual, [
          const Character(
            id: id,
            name: name,
            description: description,
            imageUrl: 'https://duckduckgo.com$imageUrl',
          ),
        ]);
      });
    });
  });
}
