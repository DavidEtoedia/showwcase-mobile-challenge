import 'package:flutter/material.dart';
import 'package:poke_mon/domain/entity/pokemon/pokemon_model.dart';
import 'package:poke_mon/presentation/widget/image_handler.dart';
import 'package:poke_mon/utils.dart';

class FavouritePokemonCard extends StatelessWidget {
  final Result result;
  final Function()? onPressed;
  const FavouritePokemonCard({super.key, required this.result, this.onPressed});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Card(
        child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ImageHandler(
          height: 100,
          width: 100,
          imageUrl: loadSprite(result.url),
        ),
        const Spacer(),
        Text(
          result.name.toString(),
          style: textTheme.displayMedium?.copyWith(
            fontSize: 25,
            fontFamily: kAppHeaderFontFamily,
            fontWeight: AppFontWeight.light,
          ),
        ),
        const Spacer(),
        IconButton(
            onPressed: onPressed,
            icon: const Icon(
              Icons.favorite,
            )),
        const Space(20),
      ],
    ));
  }
}
