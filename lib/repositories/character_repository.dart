import 'package:character_api/character_api.dart' hide CharacterAPIModel;

import '../models/character.dart';
import '../models/character_type.dart';

const baseImageUrl = 'https://duckduckgo.com';

class UndefinedCharacterType implements Exception {}

class CharacterRepository {
  final CharacterAPIClient _characterAPIClient;
  final CharacterType? _characterType;

  CharacterRepository({
    CharacterAPIClient? characterAPIClient,
    CharacterType? characterType,
  })  : _characterAPIClient = characterAPIClient ?? CharacterAPIClient(),
        _characterType = characterType;

  Future<List<Character>> getCharacters() async {
    if (_characterType == null) {
      throw UndefinedCharacterType();
    }

    final characterList = await _characterAPIClient.getCharacters(
        apiType: _characterType!
            .queryString); // we are sure this is not null because of the check

    final characters = characterList.map((element) {
      String imageUrl = '';
      if (element.imageUrl.isNotEmpty) {
        imageUrl = baseImageUrl + element.imageUrl;
      }
      return Character(
        id: element.id,
        name: element.name,
        description: element.description,
        imageUrl: imageUrl,
      );
    }).toList();
    return characters;
  }
}
