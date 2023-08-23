import 'package:character_api/character_api.dart';
import 'package:test/test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:http/http.dart' as http;

class MockHttpClient extends Mock implements http.Client {}

class MockResponse extends Mock implements http.Response {}

class FakeUri extends Fake implements Uri {}

void main() {
  group('characterApiClient', () {
    late http.Client httpClient;
    late CharacterAPIClient apiClient;

    setUpAll(() {
      registerFallbackValue(FakeUri());
    });

    setUp(() {
      httpClient = MockHttpClient();
      apiClient = CharacterAPIClient(httpClient: httpClient);
    });

    group('constructor', () {
      test('does not require an httpClient', () {
        expect(CharacterAPIClient(), isNotNull);
      });
    });

    group('Simpsons Character', () {
      const query = 'simpsons characters';

      test('makes correct http request', () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(200);
        when(() => response.body).thenReturn('{}');
        when(() => httpClient.get(any())).thenAnswer((_) async => response);

        try {
          await apiClient.getCharacters(apiType: query);
        } catch (_) {}

        verify(
          () => httpClient.get(
            Uri.https(
              'api.duckduckgo.com',
              '',
              {
                'q': 'simpsons characters',
                'format': 'json',
              },
            ),
          ),
        ).called(1);
      });

      test('throws CharacterRequestException on non-200 response', () {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(400);
        when(() => httpClient.get(any())).thenAnswer((_) async => response);
        expect(
          () async => apiClient.getCharacters(apiType: query),
          throwsA(
            isA<CharacterRequestException>(),
          ),
        );
      });

      test(
        'throws CharacterRequestJsonException when RelatedTopics key not found',
        () async {
          final response = MockResponse();
          when(() => response.statusCode).thenReturn(200);
          when(() => response.body).thenReturn('{}');
          when(() => httpClient.get(any())).thenAnswer((_) async => response);

          expect(
            () async => apiClient.getCharacters(apiType: query),
            throwsA(
              isA<CharacterRequestJsonException>(),
            ),
          );
        },
      );

      test(
        'returns Character on valid response',
        () async {
          final response = MockResponse();
          when(() => response.statusCode).thenReturn(200);
          when(() => response.body).thenReturn(
            '''
              {
                "Infobox": "",
                
                "Redirect": "",
                "RelatedTopics": [
                  {
                    "FirstURL": "https://duckduckgo.com/Apu_Nahasapeemapetilan",
                    "Icon": {
                      "Height": "",
                      "URL": "/i/99b04638.png",
                      "Width": ""
                    },
                    "Result": "<a href='https://duckduckgo.com/Apu_Nahasapeemapetilan'>Apu Nahasapeemapetilan</a><br>Apu Nahasapeemapetilan is a recurring character in the American animated television series The Simpsons.",
                    "Text": "Apu Nahasapeemapetilan - Apu Nahasapeemapetilan is a recurring character in the American animated television series The Simpsons."
                  }
                ]
              }
            ''',
          );
          when(() => httpClient.get(any())).thenAnswer((_) async => response);
          final actual = await apiClient.getCharacters(apiType: query);
          expect(
              actual,
              isA<List<CharacterAPIModel>>()
                  .having((w) => w.first.name, 'name', 'Apu Nahasapeemapetilan')
                  .having((w) => w.first.description, 'description',
                      contains('is a recurring')));
        },
      );
    });

    group('The Wire Character', () {
      const query = 'the wire characters';

      test('makes correct http request', () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(200);
        when(() => response.body).thenReturn('{}');
        when(() => httpClient.get(any())).thenAnswer((_) async => response);

        try {
          await apiClient.getCharacters(apiType: query);
        } catch (_) {}

        verify(
          () => httpClient.get(
            Uri.https(
              'api.duckduckgo.com',
              '',
              {
                'q': 'the wire characters',
                'format': 'json',
              },
            ),
          ),
        ).called(1);
      });

      test('throws CharacterRequestException on non-200 response', () {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(400);
        when(() => httpClient.get(any())).thenAnswer((_) async => response);
        expect(
          () async => apiClient.getCharacters(apiType: query),
          throwsA(
            isA<CharacterRequestException>(),
          ),
        );
      });

      test(
        'throws CharacterRequestJsonException when RelatedTopics key not found',
        () async {
          final response = MockResponse();
          when(() => response.statusCode).thenReturn(200);
          when(() => response.body).thenReturn('{}');
          when(() => httpClient.get(any())).thenAnswer((_) async => response);

          expect(
            () async => apiClient.getCharacters(apiType: query),
            throwsA(
              isA<CharacterRequestJsonException>(),
            ),
          );
        },
      );

      test(
        'returns Character on valid response',
        () async {
          final response = MockResponse();
          when(() => response.statusCode).thenReturn(200);
          when(() => response.body).thenReturn(
            '''
              {
                "Infobox": "",
                "Redirect": "",
                
                "RelatedTopics": [
                  {
                    "FirstURL": "https://duckduckgo.com/Alma_Gutierrez",
                    "Icon": {
                      "Height": "",
                      "URL": "/i/99b04638.png",
                      "Width": ""
                    },
                    "Result": "<a href='https://duckduckgo.com/Alma_Gutierrez'>Alma Gutierrez</a><br>Alma M. Gutierrez is a fictional character on the HBO drama The Wire",
                    "Text": "Alma Gutierrez - Alma M. Gutierrez is a fictional character on the HBO drama The Wire."
                  }
                ]
              }
            ''',
          );
          when(() => httpClient.get(any())).thenAnswer((_) async => response);
          final actual = await apiClient.getCharacters(apiType: query);
          expect(
              actual,
              isA<List<CharacterAPIModel>>()
                  .having((w) => w.first.name, 'name', 'Alma Gutierrez')
                  .having((w) => w.first.description, 'description',
                      contains('fictional character')));
        },
      );
    });
  });
}
