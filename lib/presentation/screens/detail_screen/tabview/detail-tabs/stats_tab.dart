import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:poke_mon/domain/entity/pokemon/pokemon_ability.dart';
import 'package:poke_mon/utils.dart';

class StatsTab extends StatelessWidget {
  final PokemonDetail data;
  const StatsTab({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: List.generate(
              data.stats!.length,
              (index) => Padding(
                    padding: const EdgeInsets.only(bottom: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(data.stats![index].stat!.name.capitalize(),
                            style: textTheme.displayMedium?.copyWith(
                              fontSize: 15,
                              fontFamily: kAppFontFamily,
                              fontWeight: AppFontWeight.semibold,
                            )),
                        const Space(20),
                        LinearPercentIndicator(
                          padding: EdgeInsets.zero,
                          backgroundColor: Colors.grey.shade300,
                          width: MediaQuery.of(context).size.width - 80,
                          animation: true,
                          lineHeight: 5,
                          percent: data.stats![index].baseStat / 200,
                          barRadius: const Radius.circular(20),
                          progressColor: Colors.green,
                        )
                      ],
                    ),
                  )),
        ),
      ],
    );
  }
}
