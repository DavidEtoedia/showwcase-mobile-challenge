import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:poke_mon/data/core/error/error_handler.dart';
import 'package:poke_mon/data/core/interceptors/cache_interceptor.dart';
import 'package:poke_mon/data/core/service/http_service.dart';
import 'package:poke_mon/data/core/storage/storage_service.dart';
import 'package:poke_mon/data/utils/pokemon_url.dart';
import 'package:poke_mon/data/core/storage/cache/config.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class DioHttpService implements HttpService {
  final StorageService storageService;
  late final Dio dio;

  DioHttpService(
    this.storageService, {
    Dio? dioOverride,
    bool enableCaching = true,
  }) {
    dio = dioOverride ?? Dio(baseOptions);

    dio.interceptors.addAll([
      if (kDebugMode) ...[PrettyDioLogger()],
      if (enableCaching) ...[CacheInterceptor(storageService)]
    ]);
  }

  /// The Dio base options
  BaseOptions get baseOptions => BaseOptions(
        connectTimeout: const Duration(milliseconds: 30000),
        receiveTimeout: const Duration(milliseconds: 30000),
        baseUrl: baseUrl,
        headers: headers,
      );

  @override
  String get baseUrl => URL.base;
  @override
  Map<String, String> headers = {
    'accept': 'application/json',
    'content-type': 'application/json',
  };

  @override
  Future<dynamic> request(String path, RequestMethod method,
      {Map<String, dynamic>? queryParams, bool forceRefresh = false}) async {
    var params = queryParams ?? {};
    dio.options.extra[Configs.dioCacheForceRefreshKey] = forceRefresh;
    try {
      var response = await dio.get(
        path,
        queryParameters: params,
      );
      return response.data;
    } on DioException catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      throw errorMessage;
    }
  }
}
