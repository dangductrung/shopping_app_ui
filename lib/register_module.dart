import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@module
abstract class RegisterModule {
  @singleton
  Future<SharedPreferences> getSharePreferences() async => SharedPreferences.getInstance();
}
