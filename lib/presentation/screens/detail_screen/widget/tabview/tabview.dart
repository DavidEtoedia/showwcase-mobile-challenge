import 'package:flutter/material.dart';
import 'package:poke_mon/domain/entity/pokemon/pokemon_ability.dart';
import 'package:poke_mon/presentation/screens/detail_screen/widget/tabview/detail-tabs/about_tab.dart';
import 'package:poke_mon/presentation/screens/detail_screen/widget/tabview/detail-tabs/stats_tab.dart';
import 'package:poke_mon/utils.dart';

class DetailTabView extends StatefulWidget {
  final PokemonDetail data;
  const DetailTabView({super.key, required this.data});

  @override
  State<DetailTabView> createState() => _DetailTabViewState();
}

class _DetailTabViewState extends State<DetailTabView>
    with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          SizedBox(
              height: 40,
              width: MediaQuery.of(context).size.width,
              // color: Colors.black,
              child: TabBar(
                isScrollable: false,
                controller: _tabController,
                splashBorderRadius: BorderRadius.circular(10),
                dividerColor: Colors.transparent,
                labelColor: Colors.black,
                labelStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      // color: AppColors.captionColor,
                      fontSize: 17,
                      letterSpacing: 0.6,
                      fontWeight: AppFontWeight.semibold,
                    ),
                unselectedLabelStyle:
                    Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontSize: 17,
                          fontWeight: AppFontWeight.light,
                        ),
                unselectedLabelColor: Colors.grey.shade400,
                labelPadding: EdgeInsets.zero,
                indicatorPadding: const EdgeInsets.only(left: -20, right: -20),
                tabs: const [
                  Tab(
                    text: 'About',
                  ),
                  Tab(
                    text: 'Stats',
                  ),
                ],
              )),
          const Space(20),
          Flexible(
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: TabBarView(
                  physics: const NeverScrollableScrollPhysics(),
                  controller: _tabController,
                  children: [
                    AboutTab(data: widget.data),
                    StatsTab(data: widget.data),
                  ]),
            ),
          ),
        ],
      ),
    );
  }
}
