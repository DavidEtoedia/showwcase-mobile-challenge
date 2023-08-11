import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:poke_mon/data/core/storage/hive_service_provider.dart';
import 'package:poke_mon/data/core/storage/hive_storage_service.dart';
import 'package:poke_mon/data/core/storage/storage_service.dart';
import 'package:poke_mon/presentation/main_screen.dart';
import 'package:poke_mon/presentation/util/appFont/app_font.dart';
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
    final textThemes = Theme.of(context).textTheme;
    final TextTheme customTheme = textThemes.apply(fontFamily: kAppFontFamily);
    return MaterialApp(
      title: 'Pokemon',
      navigatorKey: navigator.key,
      theme: ThemeData(
          useMaterial3: true,
          scaffoldBackgroundColor: Colors.white,
          textTheme: customTheme,
          fontFamily: kAppFontFamily,
          primarySwatch: Colors.blue),
      home: const MainScreen(),
    );
  }
}
