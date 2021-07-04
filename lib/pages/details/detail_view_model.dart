import 'package:get/get.dart';
import 'package:shopping_app/models/product.dart';
import 'package:shopping_app/pages/report/report_page.dart';
import 'package:shopping_app/shared/base/base_view_model.dart';

class DetailViewModel extends BaseViewModel {
  Product product;

  void onReportClicked() {
    Get.to(ReportPage(
      id: product?.id,
    ));
  }
}
