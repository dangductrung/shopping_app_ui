import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:shopping_app/backend/services/product/product_service.dart';
import 'package:shopping_app/helpers/toast_helper.dart';
import 'package:shopping_app/injector.dart';
import 'package:shopping_app/shared/base/base_view_model.dart';

class ReportViewModel extends BaseViewModel {
  int id;

  TextEditingController title = TextEditingController();
  TextEditingController content = TextEditingController();

  void onSubmitClicked() {
    if (GetUtils.isNullOrBlank(title.text) || GetUtils.isNullOrBlank(content.text)) {
      ToastHelper.showToast(msg: "Nhập đầy đủ thông tin");
      return;
    }

    call(() async {
      final Map<String, dynamic> params = {"product": id, "title": title.text, "content": content.text};
      await injector<ProductService>().sendReport(params);
      Get.back();
      ToastHelper.showToast(msg: "Gửi báo lỗi thành công");
    });
  }
}
