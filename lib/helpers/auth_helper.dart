import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopping_app/extensions/string_ext.dart';
import 'package:shopping_app/generated/locale_keys.g.dart';
import 'package:shopping_app/injector.dart';
import 'package:shopping_app/pages/signin/signin.dart';
import 'package:shopping_app/storage/storages/client_storage.dart';

@Singleton()
class AuthHelper {
  static const String localeKey = "locale";
  static const String usernameStorageKey = "username_storage";

  bool isLogined() {
    return injector<ClientStorage>().get() != null && !injector<ClientStorage>().get().isExpired();
  }

  Future<void> logout() async {
    try {
      await EasyLoading.show(status: LocaleKeys.please_wait.trans());
      await handleLogout();
      await EasyLoading.dismiss();
      await Get.offAll(SignIn());
    } catch (error) {
      await EasyLoading.dismiss();
      await Get.offAll(SignIn());
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
