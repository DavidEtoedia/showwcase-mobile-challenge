// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:poke_mon/data/core/service/http_service.dart';
import 'package:poke_mon/data/utils/pokemon_url.dart';
import 'package:poke_mon/domain/entity/pokemon/pokemon_ability.dart';
import 'package:poke_mon/domain/entity/pokemon/pokemon_model.dart';
import 'package:poke_mon/domain/repository/pokemon_repository.dart';

class PokemonImpl implements PokemonRepository {
  final HttpService httpService;
  PokemonImpl({
    required this.httpService,
  });
  @override
  Future<Pokemon> getAllPokemons([int offset = 1]) async {
    try {
      final response = await httpService.request(
        URL.requestInt(offset),
        RequestMethod.get,
      );
      return Pokemon.fromJson(response);
    } catch (e) {
      throw e.toString();
    }
  }

  @override
  Future<PokemonDetail> pokemonDetail(String name) async {
    try {
      final response = await httpService.request(
        URL.requestdetail(name),
        RequestMethod.get,
      );
      return PokemonDetail.fromJson(response);
    } catch (e) {
      throw e.toString();
    }
  }
}
