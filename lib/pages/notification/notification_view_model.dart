import 'package:shopping_app/backend/services/notification/notification_service.dart';
import 'package:shopping_app/backend/services/product/product_service.dart';
import 'package:shopping_app/injector.dart';
import 'package:shopping_app/models/chart.dart';
import 'package:shopping_app/models/notification_model.dart';
import 'package:shopping_app/models/product.dart';
import 'package:shopping_app/pages/details/details_screen.dart';
import 'package:shopping_app/shared/base/base_view_model.dart';
import 'package:get/get.dart';

class NotificationViewModel extends BaseViewModel {
  final _notifications = <NotificationModel>[].obs;
  List<NotificationModel> get notifications => _notifications.toList();
  final _isHaveLoadMore = false.obs;
  bool get isHaveLoadMore => _isHaveLoadMore.value;
  int page = 0;

  @override
  void initState() {
    getData();
    super.initState();
  }

  void getData() {
    call(() async {
      final notificationTemps = await injector<NotificationService>().getList(page);

      if (page == 0) {
        _notifications.assignAll(notificationTemps);
      } else {
        _notifications.addAll(notificationTemps);
      }
      page++;
      _isHaveLoadMore.value = !(notificationTemps?.isEmpty ?? false);
    });
  }

  @override
  void disposeState() {
    _notifications.close();
    _isHaveLoadMore.close();
    super.disposeState();
  }

  void onReadNotification(int index) {
    call(() async {
      final Product product = await injector<ProductService>().detailPrd({"product": notifications[index].link});
      final Chart chart = await injector<ProductService>().getChartData(product?.id);
      final Map<String, dynamic> params = {};
      params["keyword"] = product?.name;
      final List<Product> ref = await injector<ProductService>().search(params, 0);
      goToDetail(product, chart, ref);

      await injector<NotificationService>().read(notifications[index].id);
      notifications[index].is_read = true;
      page = 0;
      getData();
    });
  }

  void goToDetail(Product product, Chart chart, List<Product> prds) {
    Get.to(
      DetailsScreen(
        product: product,
        chart: chart,
        products: prds,
      ),
    );
  }

  void onReadAll() {
    call(() async {
      await injector<NotificationService>().readAll();
      page = 0;
      getData();
    });
  }
}
