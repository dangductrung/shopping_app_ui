import 'dart:convert';

import 'package:shopping_app/models/client.dart';
import 'package:shopping_app/storage/storage.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@lazySingleton
class ClientStorage extends Storage<Client> {
  ClientStorage(SharedPreferences prefs) : super(prefs, 'client_storage');

  @override
  Client get({Client defaultValue}) {
    if (prefs.getString(key) != null) {
      return Client.fromJson(jsonDecode(prefs.getString(key)) as Map<String, dynamic>);
    }
    return null;
  }

  @override
  void set(Client value) {
    prefs.setString(key, jsonEncode(value));
  }
}
