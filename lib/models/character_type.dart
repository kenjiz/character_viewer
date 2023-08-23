// Enhanced enum for querying of characters
enum CharacterType {
  simpsons('simpsons characters'),
  theWire('the wire characters');

  const CharacterType(this.queryString);
  final String queryString;
}
