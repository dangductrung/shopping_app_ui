import 'dart:io';

import 'package:dio/dio.dart';
import 'package:shopping_app/extensions/string_ext.dart';
import 'package:shopping_app/generated/locale_keys.g.dart';

class HttpError extends DioError {
  HttpError(DioError dioError) : super(request: dioError.request, response: dioError.response, type: dioError.type, error: dioError.error);

  @override
  String get message {
    if (error is SocketException) {
      return LocaleKeys.cannot_connect_to_server.trans();
    }

    if (response?.data is Map) {
      final StringBuffer buffer = StringBuffer();
      response?.data?.forEach((key, value) {
        if (buffer.isNotEmpty) {
          buffer.write("\n");
        }
        if (value is List) {
          buffer.write(value.join("\n"));
        } else {
          buffer.write(value);
        }
      });
      return buffer.toString();
    }

    if (response?.data is String) {
      return response?.data.toString();
    }

    return super.message;
  }
}
