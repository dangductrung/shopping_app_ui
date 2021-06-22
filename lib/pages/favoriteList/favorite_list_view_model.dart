import 'package:shopping_app/backend/services/product/product_service.dart';
import 'package:shopping_app/injector.dart';
import 'package:shopping_app/models/product.dart';
import 'package:shopping_app/models/product.dart';
import 'package:shopping_app/shared/base/base_view_model.dart';
import 'package:get/get.dart';

class FavoriteListViewModel extends BaseViewModel {
  final _products = <Product>[].obs;
  List<Product> get products => _products.toList();
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
      final productsTemp = await injector<ProductService>().getFollowList(page ?? 0);

      if (page == 0) {
        _products.assignAll(productsTemp);
      } else {
        _products.addAll(productsTemp);
      }
      _isHaveLoadMore.value = productsTemp?.isEmpty ?? false;
    });
  }

  void onUnFollowClicked(int index) {
    call(() async {
      await injector<ProductService>().unFollowProduct(products[index].id);
      _products.removeAt(index);
    });
  }
}
