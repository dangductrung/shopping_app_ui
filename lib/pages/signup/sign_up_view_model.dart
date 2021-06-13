import 'package:get/get.dart';
import 'package:shopping_app/backend/services/oauth/oauth_service.dart';
import 'package:shopping_app/pages/bottom_bar/bottombar.dart';
import 'package:shopping_app/constants/constants.dart';
import 'package:shopping_app/helpers/toast_helper.dart';
import 'package:shopping_app/injector.dart';
import 'package:shopping_app/pages/signin/signin.dart';
import 'package:shopping_app/shared/base/base_view_model.dart';
import 'package:shopping_app/storage/storages/client_storage.dart';

class SignUpViewModel extends BaseViewModel {
  String username;
  String password;
  String confirmPassword;
  // ignore: use_setters_to_change_properties
  void onUsernameChanged(String value) {
    username = value;
  }

  // ignore: use_setters_to_change_properties
  void onPwdChanged(String value) {
    password = value;
  }

  // ignore: use_setters_to_change_properties
  void onConfirmPwdChanged(String value) {
    confirmPassword = value;
  }

  void onRegisterClicked() {
    if (GetUtils.isNullOrBlank(username)) {
      ToastHelper.showToast(msg: usernameNullError);
    } else if (GetUtils.isNullOrBlank(password)) {
      ToastHelper.showToast(msg: kPassNullError);
    } else if (password.length < 8) {
      ToastHelper.showToast(msg: kShortPassError);
    } else if (password.contains(' ')) {
      ToastHelper.showToast(msg: kPassContainBlankError);
    } else if (confirmPassword != password) {
      ToastHelper.showToast(msg: kMatchPassError);
    } else {
      call(() async {
        final Map<String, dynamic> params = {};
        params["username"] = username;
        params["password"] = password;
        final client = await injector<OauthService>().register(params);
        injector<ClientStorage>().set(client);
        if (client != null) {
          goToHomePage();
        }
      });
    }
  }

  void goToHomePage() {
    Get.to(BottomBar());
  }

  void onSignInClicked() {
    Get.offAll(SignIn());
  }
}
