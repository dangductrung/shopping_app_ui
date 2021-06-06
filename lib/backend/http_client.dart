import 'dart:io';

import 'package:dio/dio.dart';
import 'package:get/get_utils/src/get_utils/get_utils.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';
import 'package:shopping_app/backend/http_error.dart';
import 'package:shopping_app/config/config.dart';
import 'package:shopping_app/helpers/auth_helper.dart';
import 'package:shopping_app/injector.dart';
import 'package:shopping_app/storage/storages/client_storage.dart';

@lazySingleton
class HttpClient {
  Dio dio = Dio();

  HttpClient() {
    dio.options = BaseOptions(
      baseUrl: Config.BASE_URL,
      connectTimeout: Config.CONNECT_TIMEOUT,
      receiveTimeout: Config.RECEIVE_TIMEOUT,
    );

    if (Config.DEBUG) {
      final Logger _logger = Logger(
        level: Config.LOG_LEVEL,
        printer: SimplePrinter(),
      );
      if (Config.LOG_LEVEL == Level.verbose) {
        dio.interceptors.add(LogInterceptor(logPrint: _logger.v, requestBody: true, responseBody: true));
      } else {
        dio.interceptors.add(LogInterceptor(logPrint: _logger.d));
      }
    }

    dio.interceptors.add(InterceptorsWrapper(onRequest: _onRequest, onError: _onError));
  }

  Future<RequestOptions> _onRequest(RequestOptions option) async {
    option.headers["Content-Type"] = "application/json";
    final String accessToken = injector<ClientStorage>()?.get()?.token ?? "";
    if (!GetUtils.isNullOrBlank(accessToken)) {
      option.headers["token"] = accessToken;
    }
    return option;
  }

  HttpError _onError(DioError e) {
    final HttpError httpError = HttpError(e);
    if (e?.response?.statusCode == HttpStatus.unauthorized) {
      injector<AuthHelper>().logout();
    }
    return httpError;
  }
}
