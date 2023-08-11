import 'package:flutter/material.dart';
import 'package:poke_mon/domain/entity/pokemon/pokemon_ability.dart';
import 'package:poke_mon/presentation/widget/image_handler.dart';
import 'package:poke_mon/utils.dart';

class AboutTab extends StatelessWidget {
  final PokemonDetail data;
  const AboutTab({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Abilities",
          style: textTheme.displayMedium?.copyWith(
            fontSize: 15,
            fontFamily: kAppFontFamily,
            color: Colors.black,
            fontWeight: AppFontWeight.semibold,
          ),
        ),
        const Space(10),
        Wrap(
            children: List.generate(
                data.abilities!.length,
                (index) => Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: Chip(
                          side: BorderSide.none,
                          backgroundColor: Colors.grey.shade200,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          label: Text(
                              data.abilities![index].ability!.name.capitalize(),
                              style: textTheme.displayMedium?.copyWith(
                                fontSize: 13,
                                fontFamily: kAppFontFamily,
                                color: Colors.black,
                                fontWeight: AppFontWeight.light,
                              ))),
                    ))),
        const Space(20),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Height",
                  style: textTheme.displayMedium?.copyWith(
                    fontSize: 15,
                    fontFamily: kAppFontFamily,
                    color: Colors.black,
                    fontWeight: AppFontWeight.semibold,
                  ),
                ),
                const Space(10),
                Text(
                  data.height.toString(),
                  style: textTheme.displayMedium?.copyWith(
                    fontSize: 20,
                    fontFamily: kAppFontFamily,
                    color: Colors.black,
                    fontWeight: AppFontWeight.light,
                  ),
                ),
              ],
            ),
            const Space(40),
            Column(
              children: [
                if (data.heldItems.isNotEmpty) ...[
                  Text(
                    "Held items",
                    style: textTheme.displayMedium?.copyWith(
                      fontSize: 15,
                      fontFamily: kAppFontFamily,
                      color: Colors.black,
                      fontWeight: AppFontWeight.semibold,
                    ),
                  ),
                  const Space(10),
                  Wrap(
                    children: List.generate(
                        data.heldItems.length,
                        (index) => ImageHandler(
                            height: 30,
                            width: 30,
                            imageUrl:
                                loadItems(data.heldItems[index].item?.name))),
                  )
                ],
              ],
            )
          ],
        ),
        const Space(20),
        Text(
          "Moves",
          style: textTheme.displayMedium?.copyWith(
            fontSize: 15,
            fontFamily: kAppFontFamily,
            color: Colors.black,
            fontWeight: AppFontWeight.semibold,
          ),
        ),
        const Space(10),
        Wrap(
          children: List.generate(
              10,
              (index) => Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: Chip(
                        side: BorderSide.none,
                        backgroundColor: Colors.grey.shade200,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        label: Text(data.moves![index].move!.name.capitalize(),
                            style: textTheme.displayMedium?.copyWith(
                              fontSize: 13,
                              fontFamily: kAppFontFamily,
                              color: Colors.black,
                              fontWeight: AppFontWeight.light,
                            ))),
                  )),
        )
      ],
    );
  }
}
