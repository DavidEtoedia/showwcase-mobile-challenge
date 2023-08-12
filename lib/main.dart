import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:poke_mon/data/core/storage/hive_service_provider.dart';
import 'package:poke_mon/data/core/storage/hive_storage_service.dart';
import 'package:poke_mon/data/core/storage/storage_service.dart';
import 'package:poke_mon/presentation/auth/login_screen.dart';
import 'package:poke_mon/presentation/theme/theme.dart';
import 'package:poke_mon/presentation/theme/theme_state.dart';
import 'package:poke_mon/presentation/util/navigator/navigator.dart';

Future<void> main() async {
  await Hive.initFlutter();
  final StorageService initializedStorageService = HiveStorageService();
  await initializedStorageService.init();
  runApp(ProviderScope(overrides: [
    storageServiceProvider.overrideWithValue(initializedStorageService),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, child) {
      final darkEnabled = ref.watch(themesModeProvider);
      return MaterialApp(
        title: 'Pokémon',
        debugShowCheckedModeBanner: false,
        navigatorKey: navigator.key,
        theme: themeBuilder(ThemeData.light()),
        darkTheme: themeBuilder(ThemeData.dark()),
        themeMode: darkEnabled,
        home: const LoginScreen(),
      );
    });
  }
}
