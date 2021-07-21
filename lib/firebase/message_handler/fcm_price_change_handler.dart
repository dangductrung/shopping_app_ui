import 'package:get/get.dart';
import 'package:shopping_app/backend/services/notification/notification_service.dart';
import 'package:shopping_app/backend/services/product/product_service.dart';
import 'package:shopping_app/injector.dart';
import 'package:shopping_app/models/notification_model.dart';
import 'package:shopping_app/models/product.dart';
import 'package:shopping_app/pages/details/details_screen.dart';

import '../fcm_payload.dart';
import 'fcm_message_handler.dart';

class FCMPriceChangeHandler extends FCMMessageHandler {
  static const type = "price_change";

  @override
  void handle(FCMPayload payload) {
    NotificationModel notificationModel;

    if (payload?.data != null) {
      notificationModel = NotificationModel.fromJson(payload?.data);
      callAPI(notificationModel);
    }
  }

  Future<void> callAPI(NotificationModel notificationModel) async {
    try {
      await injector<NotificationService>().read(notificationModel.id);
      final Product product = await injector<ProductService>().detailPrd({"product": notificationModel?.link ?? ""});
      goToDetail(product);
      // ignore: empty_catches
    } catch (e) {}
  }

  void goToDetail(Product product) {
    Get.to(
      DetailsScreen(
        product: product,
      ),
      preventDuplicates: false,
    );
  }
}
