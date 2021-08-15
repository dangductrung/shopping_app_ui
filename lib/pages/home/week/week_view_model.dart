import 'package:get/get.dart';
import 'package:shopping_app/backend/services/product/product_service.dart';
import 'package:shopping_app/injector.dart';
import 'package:shopping_app/models/product.dart';
import 'package:shopping_app/pages/details/details_screen.dart';
import 'package:shopping_app/shared/base/base_view_model.dart';

class WeekViewModel extends BaseViewModel {
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
      final productsTemp = await injector<ProductService>().saleWeek(page);
      if (page == 0) {
        _products.assignAll(productsTemp);
      } else {
        _products.addAll(productsTemp);
      }
      page++;
      _isHaveLoadMore.value = !(productsTemp?.isEmpty ?? false);
    });
  }

  void refresh() {
    page = 0;
    getData();
  }

  @override
  void disposeState() {
    _products.close();
    _isHaveLoadMore.close();
    super.disposeState();
  }

  void onItemClicked(int index) {
    Get.to(
      DetailsScreen(
        product: products[index],
      ),
      preventDuplicates: false,
    );
  }

  void onFollowClicked(int index) {
    final product = products[index];
    call(() async {
      if (product?.isFollow ?? false) {
        await injector<ProductService>().unFollowProduct(product.id);
        products[index]?.isFollow = false;
      } else {
        await injector<ProductService>().followProduct(product.id);
        products[index]?.isFollow = true;
      }
      _products.refresh();
    });
  }
}
