import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:poke_mon/presentation/home/widget/form_dialog.dart';
import 'package:poke_mon/presentation/home/widget/pokemon_card.dart';
import 'package:poke_mon/presentation/home/pagination_controller/pagination_controller.dart';
import 'package:poke_mon/presentation/screens/detail_screen/widget/retry_button.dart';
import 'package:poke_mon/presentation/theme/theme_state.dart';
import 'package:poke_mon/presentation/util/appFont/app_font.dart';
import 'package:poke_mon/presentation/util/dialog/app_dialog.dart';
import 'package:poke_mon/presentation/util/spacer/app_spacer.dart';
import 'package:poke_mon/presentation/util/text_form_input.dart';
import 'package:poke_mon/presentation/widget/loading_widget.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final pokemon = ref.watch(pokemonControllerProvider);
    final themeModeState = ref.watch(themesModeProvider);
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          AppDialog.showAppForm(
              context: context,
              child: FormDialog(
                result: pokemon.pokemon,
              ));
        },
        backgroundColor: Colors.blue,
        child: const Icon(Icons.add),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    "Pokémon",
                    style: textTheme.displayMedium?.copyWith(
                      fontSize: 50,
                      fontFamily: kAppHeaderFontFamily,
                      fontWeight: AppFontWeight.semibold,
                    ),
                  ),
                  const Spacer(),
                  Switch(
                      value: themeModeState == ThemeMode.dark,
                      onChanged: (value) {
                        ref
                            .read(themesModeProvider.notifier)
                            .changeTheme(value);
                      }),
                ],
              ),
              const Space(20),
              TextFormInput(
                labelText: "Search Pokémon",
                prefixIcon: const Icon(
                  Icons.search,
                ),
                onChanged: (value) {
                  ref
                      .read(pokemonControllerProvider.notifier)
                      .filterPokemon(value);
                },
              ),
              const Space(20),
              if (pokemon.isLoading) ...[
                const Center(
                  child: SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator()),
                )
              ],
              if (pokemon.pokemon.isNotEmpty) ...[
                Expanded(
                    child: NotificationListener<ScrollNotification>(
                        onNotification: (notification) {
                          if (notification is ScrollEndNotification &&
                              scrollController.position.extentAfter == 0) {
                            ref
                                .read(pokemonControllerProvider.notifier)
                                .loadMorePokemons();
                          }
                          return false;
                        },
                        child: GridView.builder(
                          controller: scrollController,
                          keyboardDismissBehavior:
                              ScrollViewKeyboardDismissBehavior.onDrag,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 10.0,
                            crossAxisSpacing: 15.0,
                          ),
                          itemCount: pokemon.pokemon.length,
                          itemBuilder: (context, index) {
                            final result = pokemon.pokemon[index];
                            return PokemonCard(result: result);
                          },
                        ))),
              ],
              if (pokemon.errorMessage.isNotEmpty) ...[
                Center(
                  child: RetryButton(
                      text: pokemon.errorMessage,
                      onPressed: () {
                        ref
                            .read(pokemonControllerProvider.notifier)
                            .getPokemons();
                      }),
                )
              ],
              InnerPageLoadingIndicator(loading: pokemon.hasReachedMax)
            ],
          ),
        ),
      ),
    );
  }
}
