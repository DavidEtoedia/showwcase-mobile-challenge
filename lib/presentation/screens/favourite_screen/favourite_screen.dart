import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:poke_mon/presentation/pagination_controller/pagination_controller.dart';
import 'package:poke_mon/presentation/screens/personal_pokemon/widget/personal_pokemon_card.dart';
import 'package:poke_mon/utils.dart';

class FavouriteScreen extends HookConsumerWidget {
  const FavouriteScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textTheme = Theme.of(context).textTheme;

    final pokemon = ref.watch(pokemonControllerProvider);
    final favourite = pokemon.pokemon.where((e) => e.isLike == true).toList();
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Space(30),
              Text(
                "Favourite Pokemon",
                style: textTheme.bodyLarge?.copyWith(
                  fontSize: 30,
                  fontFamily: kAppFontFamily,
                  color: Colors.black,
                  fontWeight: AppFontWeight.bold,
                ),
              ),
              const Space(30),
              Expanded(
                  child: ListView.separated(
                itemCount: favourite.length,
                itemBuilder: (context, index) {
                  final fav = favourite[index];
                  return PersonalPokemonCard(result: fav);
                },
                separatorBuilder: (context, index) => const SizedBox(
                  height: 20,
                ),
              ))
            ],
          ),
        ),
      ),
    );
  }
}
