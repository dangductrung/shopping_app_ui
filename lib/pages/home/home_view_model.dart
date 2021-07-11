import 'package:shopping_app/backend/services/product/product_service.dart';
import 'package:shopping_app/firebase/fcm_manager.dart';
import 'package:shopping_app/injector.dart';
import 'package:shopping_app/models/poster.dart';
import 'package:shopping_app/models/product.dart';
import 'package:shopping_app/pages/search/search_page.dart';
import 'package:shopping_app/shared/base/base_view_model.dart';
import 'package:get/get.dart';

class HomeViewModel extends BaseViewModel {
  final _products = <Product>[].obs;
  List<Product> get products => _products.toList();
  final _poster = Poster().obs;
  Poster get poster => _poster.value;

  @override
  void initState() {
    injector<FCMManager>().configNotification(Get.context);
    injector<FCMManager>().registerFcmToken();
    getData();
    super.initState();
  }

  void getData() {
    call(() async {
      _products.assignAll(await injector<ProductService>().getListLastItem());
      _poster.value = await injector<ProductService>().getPoster();
    });
  }

  void onFollowClicked(int i) {
    call(() async {
      if (products[i]?.isFollow ?? false) {
        await injector<ProductService>().unFollowProduct(products[i].id);
      } else {
        await injector<ProductService>().followProduct(products[i].id);
      }
      getData();
    });
  }

  @override
  void disposeState() {
    _products.close();
    _poster.close();
    super.disposeState();
  }

  void onSearchClicked(String text) {
    Get.to(
      SearchPage(
        searchText: text,
      ),
    );
  }
}
