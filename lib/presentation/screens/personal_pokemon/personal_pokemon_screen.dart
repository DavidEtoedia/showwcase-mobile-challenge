import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:poke_mon/presentation/screens/personal_pokemon/controller/personal_pokenmon_controller.dart';
import 'package:poke_mon/presentation/screens/personal_pokemon/widget/personal_pokemon_card.dart';
import 'package:poke_mon/presentation/util/appFont/app_font.dart';
import 'package:poke_mon/presentation/util/spacer/app_spacer.dart';

class PersonPokeMon extends StatelessWidget {
  const PersonPokeMon({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: SafeArea(
        child: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Consumer(builder: (context, ref, child) {
              final savedPokemon = ref.watch(personalPokemonProvider);
              return Column(
                children: [
                  const Space(20),
                  Text(
                    "Personal Pokémon",
                    style: textTheme.bodyLarge?.copyWith(
                      fontSize: 35,
                      fontFamily: kAppHeaderFontFamily,
                      fontWeight: AppFontWeight.bold,
                    ),
                  ),
                  const Space(30),
                  if (savedPokemon.isEmpty)
                    Center(
                      child: Text(
                        "You have no Personal Pokémon",
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
                      itemCount: savedPokemon.length,
                      itemBuilder: (context, index) {
                        final saved = savedPokemon[index];
                        return PersonalPokemonCard(
                          result: saved,
                          onPressed: () {
                            ref
                                .read(personalPokemonProvider.notifier)
                                .removePokeMon(saved);
                          },
                        );
                      },
                      separatorBuilder: (context, index) => const SizedBox(
                        height: 20,
                      ),
                    ))
                ],
              );
            })),
      ),
    );
  }
}
