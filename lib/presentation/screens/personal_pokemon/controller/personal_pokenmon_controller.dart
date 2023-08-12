import 'package:equatable/equatable.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:poke_mon/domain/entity/pokemon/pokemon_model.dart';
import 'package:poke_mon/presentation/home/pagination_controller/pagination_controller.dart';

class PersonalPokemonState extends Equatable {
  final List<Result> pokemon;

  const PersonalPokemonState({
    required this.pokemon,
  });

  factory PersonalPokemonState.initial() {
    return const PersonalPokemonState(
      pokemon: [],
    );
  }

  PersonalPokemonState copyWith({final List<Result>? pokemon}) {
    return PersonalPokemonState(
      pokemon: pokemon ?? this.pokemon,
    );
  }

  @override
  List<Object?> get props => [
        pokemon,
      ];
}

final personalPokemonProvider =
    StateNotifierProvider<PersonalPokemonController, PersonalPokemonState>(
  (ref) => PersonalPokemonController(ref),
);

class PersonalPokemonController extends StateNotifier<PersonalPokemonState> {
  final Ref ref;
  PersonalPokemonController(this.ref) : super(PersonalPokemonState.initial());

  void addPokemon(String text) {
    final pokemon = ref.watch(pokemonControllerProvider);
    List<Result> matchingPokemon = [];

    for (var value in pokemon.pokemon) {
      if (value.name.contains(text)) {
        matchingPokemon.add(value);
      }
    }

    if (matchingPokemon.isNotEmpty) {
      state = state.copyWith(pokemon: [...state.pokemon, ...matchingPokemon]);
    }
  }

  removePokeMon(Result target) {
    state.pokemon.remove(target);

    state = state.copyWith(pokemon: [
      for (final step in state.pokemon)
        if (step == target) state.pokemon.removeLast() else step,
    ]);
  }
}
