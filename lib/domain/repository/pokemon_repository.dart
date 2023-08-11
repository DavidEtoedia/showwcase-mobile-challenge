import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:poke_mon/data/core/service/http_service_provider.dart';
import 'package:poke_mon/domain/entity/pokemon/pokemon_model.dart';
import 'package:poke_mon/domain/repository/pokemon_implementation.dart';

final pokemonRepositoryProvider = Provider<PokemonImpl>((ref) {
  final httpService = ref.watch(httpServiceProvider);
  return PokemonImpl(httpService: httpService);
});

abstract class PokemonRepository {
  Future<Pokemon> getAllPokemons([int offset = 1]);
}
