import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:poke_mon/domain/entity/pokemon/pokemon_model.dart';
import 'package:poke_mon/domain/repository/pokemon_implementation.dart';
import 'package:poke_mon/domain/repository/pokemon_repository.dart';

enum PokemonStatus { initial, success, failure }

class PokemonState extends Equatable {
  final String? errorMessage;
  final List<Result> pokemon;
  final List<Result> filterPokemon;
  final int pages;
  final bool isLoading;
  final bool hasReachedMax;

  const PokemonState(
      {this.errorMessage,
      required this.pokemon,
      required this.hasReachedMax,
      required this.filterPokemon,
      required this.pages,
      required this.isLoading});

  factory PokemonState.initial() {
    return const PokemonState(
        pokemon: [],
        filterPokemon: [],
        pages: 20,
        errorMessage: '',
        isLoading: false,
        hasReachedMax: false);
  }

  PokemonState copyWith(
      {final String? errorMessage,
      final bool? isLoading,
      final bool? hasReachedMax,
      final int? pages,
      final List<Result>? filterPokemon,
      final List<Result>? pokemon}) {
    return PokemonState(
      pokemon: pokemon ?? this.pokemon,
      filterPokemon: filterPokemon ?? this.filterPokemon,
      pages: pages ?? this.pages,
      isLoading: isLoading ?? this.isLoading,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props =>
      [pokemon, errorMessage, pages, filterPokemon, isLoading, hasReachedMax];
}

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
    state = state.copyWith(isLoading: true);
    try {
      final pokemon = await _photoRepository.getAllPokemons(state.pages);
      state = state.copyWith(
          pokemon: pokemon.results,
          pages: page,
          filterPokemon: pokemon.results,
          isLoading: false);
    } catch (e) {
      state.copyWith(errorMessage: e.toString());
      state = state.copyWith(isLoading: false);
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
      log("PAGE COUNT ------------> ${page}");
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
        if (res.name!.contains(value)) {
          state = state.copyWith(pokemon: state.filterPokemon);
        }
      }
      results = state.pokemon
          .where((element) =>
              element.name!.toLowerCase().contains(value.toLowerCase()))
          .toList();

      state = state.copyWith(pokemon: results);
    }
  }

  bool containsLetterOneByOne(String text, String letter) {
    for (int i = 0; i < text.length; i++) {
      if (text[i].toLowerCase() == letter.toLowerCase()) {
        return true;
      }
    }
    return false;
  }
}
