import 'package:equatable/equatable.dart';
import 'package:poke_mon/domain/entity/pokemon/pokemon_model.dart';

class PokemonState extends Equatable {
  final String errorMessage;
  final List<Result> pokemon;
  final List<Result> filterPokemon;
  final int pages;
  final bool isLoading;
  final bool hasReachedMax;

  const PokemonState(
      {required this.errorMessage,
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
