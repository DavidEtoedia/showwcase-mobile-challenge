import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:poke_mon/presentation/home/pagination_controller/pagination_controller.dart';
import 'package:poke_mon/presentation/screens/favourite_screen/widget/favourite_card.dart';
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
            children: [
              const Space(20),
              Text(
                "Favourite Pokemon",
                style: textTheme.bodyLarge?.copyWith(
                  fontSize: 35,
                  fontFamily: kAppHeaderFontFamily,
                  fontWeight: AppFontWeight.bold,
                ),
              ),
              const Space(30),
              if (favourite.isEmpty)
                Center(
                  child: Text(
                    "You have no favourite pokemon",
                    style: textTheme.bodyLarge?.copyWith(
                      fontSize: 15,
                      fontFamily: kAppFontFamily,
                      fontWeight: AppFontWeight.light,
                    ),
                  ),
                )
              else
                Expanded(
                    child: ListView.separated(
                  itemCount: favourite.length,
                  itemBuilder: (context, index) {
                    final fav = favourite[index];
                    return FavouritePokemonCard(
                      result: fav,
                      onPressed: () {
                        ref
                            .read(pokemonControllerProvider.notifier)
                            .toggle(fav.name);
                      },
                    );
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
