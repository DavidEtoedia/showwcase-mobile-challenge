import 'package:flutter/material.dart';
import 'package:poke_mon/domain/entity/pokemon/pokemon_model.dart';
import 'package:poke_mon/presentation/util/appFont/app_font.dart';
import 'package:poke_mon/presentation/widget/image_handler.dart';

class PokemonCard extends StatelessWidget {
  final Result result;
  const PokemonCard({super.key, required this.result});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Container(
        decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: BorderRadius.circular(10)),
        child: Column(
          children: [
            ImageHandler(
              imageUrl: result.url,
            ),
            Expanded(
              child: Text(
                result.name.toString(),
                style: textTheme.displayMedium?.copyWith(
                  fontSize: 25,
                  fontFamily: kAppHeaderFontFamily,
                  color: Colors.black,
                  fontWeight: AppFontWeight.light,
                ),
              ),
            ),
          ],
        ));
  }
}
