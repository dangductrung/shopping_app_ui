import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopping_app/extensions/string_ext.dart';
import 'package:shopping_app/generated/locale_keys.g.dart';
import 'package:shopping_app/injector.dart';

@Singleton()
class AuthHelper {
  static const String localeKey = "locale";
  static const String usernameStorageKey = "username_storage";

  Future<void> logout() async {
    // if (!(await injector<Oauth2Manager>().isLoggedIn())) {
    //   return;
    // }
    try {
      await EasyLoading.show(status: LocaleKeys.please_wait.trans());
      await handleLogout();
      await EasyLoading.dismiss();
      // await Get.offAll(LoginScreen());
    } catch (error) {
      await EasyLoading.dismiss();
      // await Get.offAll(LoginScreen());
    }
  }

  Future<void> handleLogout() async {
    await deleteFCMToken();
    await clearPrefs();
  }

  Future<void> clearPrefs() async {
    for (final key in injector<SharedPreferences>().getKeys()) {
      if (key != localeKey && key != usernameStorageKey) {
        await injector<SharedPreferences>().remove(key);
      }
    }
  }

  Future<void> deleteFCMToken() async {
    // final String fcmToken = injector<FCMTokenStorage>().get();
    // if (!GetUtils.isNullOrBlank(fcmToken)) {
    //   await injector<FirebaseService>().deleteFCMToken(injector<FCMTokenStorage>().get());
    // }
  }
}
