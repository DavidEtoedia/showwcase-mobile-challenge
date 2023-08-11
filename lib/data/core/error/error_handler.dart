import 'package:dio/dio.dart';
import 'package:poke_mon/data/core/error/http_error_strings.dart';

class DioExceptions implements Exception {
  late String message;

  DioExceptions.fromDioError(DioException dioError) {
    switch (dioError.type) {
      case DioExceptionType.connectionTimeout:
        message = HttpErrorStrings.connectionTimeoutActive;
        break;
      case DioExceptionType.connectionError:
        message = HttpErrorStrings.connectionTimeoutActive;
        break;
      case DioExceptionType.receiveTimeout:
        message = HttpErrorStrings.receiveTimeout;
        break;
      case DioExceptionType.badResponse:
        message = HttpErrorStrings.badResponse;
        break;
      case DioExceptionType.sendTimeout:
        message = HttpErrorStrings.sendTimeout;
        break;
      case DioExceptionType.unknown:
        if (dioError.error.toString().contains("SocketException")) {
          message = HttpErrorStrings.genericRes;
          break;
        }
        message = HttpErrorStrings.uknown;
        break;
      default:
        message = "Something went wrong please try again later";
        break;
    }
  }

  @override
  String toString() => message;
}
