import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:poke_mon/data/core/service/dio_http_service.dart';
import 'package:poke_mon/data/core/service/http_service.dart';
import 'package:poke_mon/data/core/storage/hive_service_provider.dart';

final httpServiceProvider = Provider<HttpService>((ref) {
  final storageService = ref.watch(storageServiceProvider);
  return DioHttpService(storageService);
});
