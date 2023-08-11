import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:poke_mon/domain/entity/pokemon/pokemon_model.dart';
import 'package:poke_mon/presentation/pagination_controller/pagination_controller.dart';
import 'package:poke_mon/presentation/screens/detail_screen/provider/pokemon_detail_provider.dart';
import 'package:poke_mon/presentation/screens/detail_screen/widget/tabview/tabview.dart';
import 'package:poke_mon/presentation/widget/image_handler.dart';
import 'package:poke_mon/utils.dart';

class PokemonDetailScreen extends ConsumerStatefulWidget {
  final Result result;
  const PokemonDetailScreen({super.key, required this.result});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _PokemonDetailScreenState();
}

class _PokemonDetailScreenState extends ConsumerState<PokemonDetailScreen> {
  @override
  Widget build(BuildContext context) {
    final detailProvider =
        ref.watch(pokemondetailsProvider(widget.result.name));
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 25, right: 25),
          child: Column(
            children: [
              Text(
                widget.result.name,
                style: textTheme.displayMedium?.copyWith(
                  fontSize: 70,
                  fontFamily: kAppHeaderFontFamily,
                  color: Colors.black,
                  fontWeight: AppFontWeight.light,
                ),
              ),
              Center(
                child: Hero(
                    tag: "image ${widget.result.name}",
                    child: ImageHandler(
                        height: 150,
                        width: 150,
                        imageUrl: loadSprite(widget.result.url))),
              ),
              detailProvider.when(
                  data: (data) {
                    return DetailTabView(data: data);
                  },
                  error: (e, s) => Text(e.toString()),
                  loading: () =>
                      const Center(child: CircularProgressIndicator()))
            ],
          ),
        ),
      ),
    );
  }
}
