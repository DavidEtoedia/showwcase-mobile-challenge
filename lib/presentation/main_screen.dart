import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:poke_mon/presentation/home/home.dart';
import 'package:poke_mon/presentation/screens/favourite_screen/favourite_screen.dart';
import 'package:poke_mon/presentation/screens/personal_pokemon/personal_pokemon_screen.dart';

class MainScreen extends StatefulHookConsumerWidget {
  const MainScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MainScreenState();
}

class _MainScreenState extends ConsumerState<MainScreen> {
  int pageIndex = 0;

  List<Widget> pageList = <Widget>[
    const HomeScreen(),
    const PersonPokeMon(),
    const FavouriteScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      pageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: pageList.elementAt(pageIndex),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: pageIndex,
          onTap: _onItemTapped,
          type: BottomNavigationBarType.fixed,
          elevation: 20,
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.bolt_outlined),
                activeIcon: Icon(Icons.bolt),
                label: 'Home'),
            BottomNavigationBarItem(
                icon: Icon(Icons.cyclone_outlined),
                activeIcon: Icon(Icons.cyclone),
                label: 'Personal'),
            BottomNavigationBarItem(
                icon: Icon(Icons.favorite_outline_outlined),
                activeIcon: Icon(Icons.favorite),
                label: 'Favourite'),
          ],
        ));
  }
}
