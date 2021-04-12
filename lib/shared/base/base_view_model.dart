import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:shopping_app/backend/http_error.dart';
import 'package:shopping_app/extensions/string_ext.dart';
import 'package:shopping_app/generated/locale_keys.g.dart';
import 'package:shopping_app/helpers/toast_helper.dart';

class BaseViewModel {
  dynamic _error;

  void initState() {}

  void disposeState() {}

  String get errorMessage {
    if (_error == null) {
      return null;
    }

    if (_error is HttpError) {
      final HttpError httpError = _error as HttpError;
      return httpError.message;
    }

    return _error.toString();
  }

  @protected
  Future<bool> call(dynamic Function() handler, {String defaultErrorMessage, bool toastOnError = true, bool background = false}) async {
    try {
      _error = null;
      if (!background) {
        await EasyLoading.show(status: LocaleKeys.please_wait.trans());
      }
      final result = handler();
      if (result is Future) {
        await result;
      }
      if (!background) {
        await EasyLoading.dismiss();
      }
      return true;
    } catch (e) {
      _error = e;
      if (!background) {
        await EasyLoading.dismiss();
      }
      if (toastOnError) {
        ToastHelper.showToast(msg: defaultErrorMessage ?? errorMessage);
      }
      return false;
    }
  }
}
