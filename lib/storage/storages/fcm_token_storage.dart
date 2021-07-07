import 'dart:convert';

import 'package:shopping_app/storage/storage.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@lazySingleton
class FCMTokenStorage extends Storage<String> {
  FCMTokenStorage(SharedPreferences prefs) : super(prefs, 'fcm_token_storage');

  @override
  String get({String defaultValue}) {
    return prefs.getString(key) ?? defaultValue;
  }

  @override
  void set(String value) {
    prefs.setString(key, value);
  }
}
