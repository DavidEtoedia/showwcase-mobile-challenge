import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:poke_mon/domain/entity/pokemon/pokemon_model.dart';

final personalPokemonProvider =
    StateNotifierProvider<PersonalPokemonController, List<Result>>(
  (ref) => PersonalPokemonController(ref),
);

class PersonalPokemonController extends StateNotifier<List<Result>> {
  final Ref ref;
  PersonalPokemonController(this.ref) : super([]);

  void addPokemon(String text, List<Result> result) {
    List<Result> matchingPokemon = [];

    for (var value in result) {
      if (value.name.contains(text)) {
        var saved = Result(name: value.name, url: value.url);
        if (!state.contains(saved)) {
          matchingPokemon.add(saved);
        }

        break;
      }
    }

    if (matchingPokemon.isNotEmpty) {
      state = [...state, ...matchingPokemon];
    }
  }

  removePokeMon(Result target) {
    state.remove(target);

    state = [
      for (final step in state)
        if (step == target) state.removeLast() else step,
    ];
  }
}
