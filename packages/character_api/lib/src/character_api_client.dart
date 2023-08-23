import 'dart:convert';

import 'package:http/http.dart' as http;

import 'model/character_api_model.dart';

/// Exception thrown when characterGet fails
class CharacterRequestException implements Exception {}

// Exception thrown when there's no specific key found in the json response
class CharacterRequestJsonException implements Exception {}

/// Dart API client that wraps the [DuckDuckGo API](https://api.duckduckgo.com) in order to get the character list.
/// The API Json response should contain the key 'RelatedTopics'
class CharacterAPIClient {
  static const _baseAPIUrl = 'api.duckduckgo.com';
  final http.Client _httpClient;

  CharacterAPIClient({http.Client? httpClient})
      : _httpClient = httpClient ?? http.Client();

  /// Fetches list of [CharacterAPIModel] for a given [CharacterAPIType]
  Future<List<CharacterAPIModel>> getCharacters({
    required String apiType,
  }) async {
    final characterRequest = Uri.https(
      _baseAPIUrl,
      '',
      {
        'q': apiType,
        'format': 'json',
      },
    );

    final characterResponse = await _httpClient.get(characterRequest);
    if (characterResponse.statusCode != 200) {
      throw CharacterRequestException();
    }

    final responseJson = jsonDecode(characterResponse.body);

    if (!responseJson.containsKey('RelatedTopics')) {
      throw CharacterRequestJsonException();
    }

    final characterList =
        (responseJson['RelatedTopics'] as List).map((element) {
      final entry = element as Map<String, dynamic>;
      return CharacterAPIModel.fromMap(entry);
    }).toList();

    return characterList;
  }
}
