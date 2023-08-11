class URL {
  static const base = "https://pokeapi.co/api/v2/";
  static const pokemon = "pokemon/?limit=20&offset=20";
  static String requestAPIUrl(int pokemonId) =>
      'https://pokeapi.co/api/v2/pokemon/$pokemonId';
  static String requestInt(int offset) => 'pokemon/?limit=20&offset=$offset';
}
