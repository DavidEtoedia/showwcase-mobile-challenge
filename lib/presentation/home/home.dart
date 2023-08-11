import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:poke_mon/presentation/home/widget/pokemon_card.dart';
import 'package:poke_mon/presentation/pagination_controller/pagination_controller.dart';
import 'package:poke_mon/presentation/util/appFont/app_font.dart';
import 'package:poke_mon/presentation/util/spacer/app_spacer.dart';
import 'package:poke_mon/presentation/widget/loading_widget.dart';
import 'package:poke_mon/presentation/widget/search_box.dart';

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
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Space(20),
              Text(
                "Pokemon",
                style: textTheme.displayMedium?.copyWith(
                  fontSize: 50,
                  fontFamily: kAppHeaderFontFamily,
                  color: Colors.black,
                  fontWeight: AppFontWeight.semibold,
                ),
              ),
              const Space(20),
              SearchBox(
                onTextEntered: (value) {
                  ref
                      .read(pokemonControllerProvider.notifier)
                      .filterPokemon(value);
                },
              ),
              const Space(20),
              pokemon.isLoading
                  ? const Center(
                      child: SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator()),
                    )
                  : Expanded(
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
                              crossAxisSpacing: 10.0,
                            ),
                            itemCount: pokemon.pokemon.length,
                            itemBuilder: (context, index) {
                              final result = pokemon.pokemon[index];
                              return PokemonCard(result: result);
                            },
                          ))),
              InnerPageLoadingIndicator(loading: pokemon.hasReachedMax)
            ],
          ),
        ),
      ),
    );
  }
}
