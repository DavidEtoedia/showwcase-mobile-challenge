class URL {
  static const base = "https://pokeapi.co/api/v2/";
  static const pokemon = "pokemon/?limit=20&offset=20";
  static String requestdetail(String name) =>
      'pokemon/$name/?limit=20&offset=20';
  static String requestInt(int offset) => 'pokemon/?limit=20&offset=$offset';
}
