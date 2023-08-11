import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:poke_mon/domain/entity/pokemon/pokemon_ability.dart';
import 'package:poke_mon/domain/repository/pokemon_repository.dart';

final pokemondetailsProvider =
    FutureProvider.family<PokemonDetail, String>((ref, name) async {
  return ref.watch(pokemonRepositoryProvider).pokemonDetail(name);
});
