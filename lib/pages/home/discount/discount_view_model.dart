import 'package:shopping_app/backend/services/product/product_service.dart';
import 'package:shopping_app/injector.dart';
import 'package:shopping_app/models/fluctuation.dart';
import 'package:shopping_app/models/product.dart';
import 'package:shopping_app/pages/details/details_screen.dart';
import 'package:shopping_app/shared/base/base_view_model.dart';
import 'package:get/get.dart';

class DiscountViewModel extends BaseViewModel {
  final _fluctuation = <Fluctuation>[].obs;
  List<Fluctuation> get fluctuation => _fluctuation.toList();
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
      final productsTemp = await injector<ProductService>().fluctuation(page);
      if (page == 0) {
        _fluctuation.assignAll(productsTemp);
      } else {
        _fluctuation.addAll(productsTemp);
      }
      page++;
      _isHaveLoadMore.value = !(productsTemp?.isEmpty ?? false);
    }, background: page > 0);
  }

  void refresh() {
    page = 0;
    getData();
  }

  @override
  void disposeState() {
    _fluctuation.close();
    _isHaveLoadMore.close();
    super.disposeState();
  }

  void onItemClicked(int index) {
    gotoProduct(fluctuation[index].product);
  }

  Future<void> trackProduct(Product product) async {
    await injector<ProductService>().track(product.id);
  }

  void gotoProduct(Product product) {
    trackProduct(product);
    Get.to(
      DetailsScreen(
        product: product,
      ),
      preventDuplicates: false,
    );
  }

  void onFollowClicked(int index) {
    final product = fluctuation[index].product;
    call(() async {
      if (product?.isFollow ?? false) {
        await injector<ProductService>().unFollowProduct(product.id);
        fluctuation[index].product?.isFollow = false;
      } else {
        await injector<ProductService>().followProduct(product.id);
        fluctuation[index].product?.isFollow = true;
      }
      _fluctuation.refresh();
    });
  }
}
