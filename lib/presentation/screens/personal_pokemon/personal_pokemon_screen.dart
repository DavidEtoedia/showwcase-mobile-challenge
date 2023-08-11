import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:poke_mon/presentation/screens/personal_pokemon/controller/personal_pokenmon_controller.dart';
import 'package:poke_mon/presentation/screens/personal_pokemon/widget/personal_pokemon_card.dart';
import 'package:poke_mon/presentation/util/appFont/app_font.dart';
import 'package:poke_mon/presentation/util/spacer/app_spacer.dart';

class PersonPokeMon extends ConsumerWidget {
  const PersonPokeMon({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final savedPokemon = ref.watch(personalPokemonProvider);
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Space(30),
              Text(
                "Personal Pokemon",
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
                itemCount: savedPokemon.pokemon.length,
                itemBuilder: (context, index) {
                  final saved = savedPokemon.pokemon[index];
                  return PersonalPokemonCard(result: saved);
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
