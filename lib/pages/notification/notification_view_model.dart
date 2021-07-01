import 'package:shopping_app/backend/services/notification/notification_service.dart';
import 'package:shopping_app/injector.dart';
import 'package:shopping_app/models/notification_model.dart';
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
      await injector<NotificationService>().read(notifications[index].id);
      page = 0;
      getData();
    });
  }

  void onReadAll() {
    call(() async {
      await injector<NotificationService>().readAll();
      page = 0;
      getData();
    });
  }
}
