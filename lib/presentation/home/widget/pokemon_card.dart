import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:poke_mon/domain/entity/pokemon/pokemon_model.dart';
import 'package:poke_mon/presentation/home/pagination_controller/pagination_controller.dart';
import 'package:poke_mon/presentation/screens/detail_screen/pokemon_detail_screen.dart';
import 'package:poke_mon/presentation/util/appFont/app_font.dart';
import 'package:poke_mon/presentation/util/navigator/navigator.dart';
import 'package:poke_mon/presentation/util/spacer/app_spacer.dart';
import 'package:poke_mon/presentation/widget/image_handler.dart';

class PokemonCard extends ConsumerWidget {
  final Result result;
  const PokemonCard({super.key, required this.result});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textTheme = Theme.of(context).textTheme;
    return InkWell(
      onTap: () => context.navigate(PokemonDetailScreen(result: result)),
      child: Card(
          child: Column(
        children: [
          Align(
            alignment: Alignment.topRight,
            child: IconButton(
                onPressed: () {
                  ref
                      .read(pokemonControllerProvider.notifier)
                      .toggle(result.name);
                },
                icon: result.isLike
                    ? const Icon(
                        Icons.favorite,
                      )
                    : const Icon(
                        Icons.favorite_border_outlined,
                      )),
          ),
          Expanded(
            child: Hero(
              tag: "image ${result.name}",
              child: ImageHandler(
                height: 100,
                width: 100,
                imageUrl: loadSprite(result.url),
              ),
            ),
          ),
          Text(
            result.name.toString(),
            style: textTheme.displayMedium?.copyWith(
              fontSize: 25,
              fontFamily: kAppHeaderFontFamily,
              fontWeight: AppFontWeight.light,
            ),
          ),
          const Space(10)
        ],
      )),
    );
  }
}
