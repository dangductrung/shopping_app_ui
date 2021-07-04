import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:shopping_app/backend/services/profile/profile_service.dart';
import 'package:shopping_app/helpers/toast_helper.dart';
import 'package:shopping_app/injector.dart';
import 'package:shopping_app/shared/base/base_view_model.dart';

class ChangePwViewModel extends BaseViewModel {
  Function() onChangePwSuccess;
  TextEditingController oldPw = TextEditingController();
  TextEditingController newPw = TextEditingController();
  TextEditingController renewPw = TextEditingController();

  void onChangePwClicked() {
    if (GetUtils.isNullOrBlank(oldPw.text) || GetUtils.isNullOrBlank(newPw.text) || GetUtils.isNullOrBlank(renewPw.text)) {
      ToastHelper.showToast(msg: "Nhập tất cả thông tin.");
      return;
    }

    if (newPw.text != renewPw.text) {
      ToastHelper.showToast(msg: "Mật khẩu mới không giống nhau.");
      return;
    }

    call(() async {
      final Map<String, dynamic> params = {"oldPw": oldPw.text, "newPw": newPw.text};
      await injector<ProfileService>().changePw(params);
      if (onChangePwSuccess != null) {
        onChangePwSuccess();
        ToastHelper.showToast(msg: "Đổi mật khẩu thành công.");
        Get.back();
      }
    });
  }
}
