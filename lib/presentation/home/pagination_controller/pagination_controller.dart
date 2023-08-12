import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:poke_mon/domain/entity/pokemon/pokemon_model.dart';
import 'package:poke_mon/domain/repository/pokemon_implementation.dart';
import 'package:poke_mon/domain/repository/pokemon_repository.dart';
import 'package:poke_mon/presentation/home/pagination_controller/pokemon_state.dart';

final pokemonControllerProvider =
    StateNotifierProvider<PokemonController, PokemonState>(
  (ref) => PokemonController(
    ref.read(pokemonRepositoryProvider),
  ),
);

class PokemonController extends StateNotifier<PokemonState> {
  final PokemonImpl _photoRepository;
  PokemonController(
    this._photoRepository,
  ) : super(PokemonState.initial()) {
    getPokemons();
  }

  int page = 20;

  Future<void> getPokemons() async {
    state = state.copyWith(isLoading: true, errorMessage: "");
    try {
      final pokemon = await _photoRepository.getAllPokemons(state.pages);
      state = state.copyWith(
          pokemon: pokemon.results,
          pages: page,
          filterPokemon: pokemon.results,
          isLoading: false);
    } catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: e.toString());
    }
  }

  /// Load more Pokemon

  Future<void> loadMorePokemons() async {
    page += 2;
    try {
      state = state.copyWith(hasReachedMax: true);
      final pokemon = await _photoRepository.getAllPokemons(page);
      state = state.copyWith(
          pokemon: List.of(state.pokemon)
            ..addAll(
              pokemon.results!.toList(),
            ),
          filterPokemon: List.of(state.pokemon)
            ..addAll(
              pokemon.results!.toList(),
            ),
          pages: state.pages + 2,
          hasReachedMax: false);
    } catch (e) {
      state.copyWith(errorMessage: e.toString());
      state = state.copyWith(hasReachedMax: false);
    }
  }

// Filter pokemon by name

  void filterPokemon(String value) {
    List<Result> results = [];

    results = [...state.pokemon];
    if (value.isEmpty) {
      state = state.copyWith(pokemon: state.filterPokemon);
    } else {
      for (var res in state.filterPokemon) {
        if (res.name.contains(value)) {
          state = state.copyWith(pokemon: state.filterPokemon);
        }
      }
      results = state.pokemon
          .where((element) =>
              element.name.toLowerCase().contains(value.toLowerCase()))
          .toList();

      state = state.copyWith(pokemon: results);
    }
  }

  /// toggle favourite pokemon

  void toggle(String id) {
    state = state.copyWith(pokemon: [
      for (final todo in state.pokemon)
        if (todo.name == id)
          Result(
            name: todo.name,
            url: todo.url,
            isLike: !todo.isLike,
          )
        else
          todo,
    ]);
  }
}
