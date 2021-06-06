import 'package:get/get.dart';
import 'package:shopping_app/backend/services/oauth/oauth_service.dart';
import 'package:shopping_app/common/bottombar.dart';
import 'package:shopping_app/constants/constants.dart';
import 'package:shopping_app/helpers/toast_helper.dart';
import 'package:shopping_app/injector.dart';
import 'package:shopping_app/shared/base/base_view_model.dart';
import 'package:shopping_app/storage/storages/client_storage.dart';

class SignInViewModel extends BaseViewModel {
  String username = "";
  String password = "";

  void onBtnClicked() {
    if (GetUtils.isNullOrBlank(password)) {
      ToastHelper.showToast(msg: kPassNullError);
      return;
    } else if (password.length < 8) {
      ToastHelper.showToast(msg: kShortPassError);
      return;
    } else if (GetUtils.isNullOrBlank(username)) {
      ToastHelper.showToast(msg: usernameNullError);
      return;
    }

    call(() async {
      final Map<String, dynamic> params = {};
      params["username"] = username;
      params["password"] = password;
      final client = await injector<OauthService>().login(params);
      injector<ClientStorage>().set(client);
      if (client != null) {
        goToHomePage();
      }
    });
  }

  void goToHomePage() {
    Get.to(BottomBar());
  }

  // ignore: use_setters_to_change_properties
  void onPassChanged(String value) {
    password = value;
  }

  // ignore: use_setters_to_change_properties
  void onUsernameChanged(String value) {
    username = value;
  }
}
