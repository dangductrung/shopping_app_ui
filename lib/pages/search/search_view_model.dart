import 'package:flutter/cupertino.dart';
import 'package:shopping_app/backend/services/product/product_service.dart';
import 'package:shopping_app/event_bus/event_bus_helper.dart';
import 'package:shopping_app/event_bus/update_follow_event_bus.dart';
import 'package:shopping_app/injector.dart';
import 'package:shopping_app/models/product.dart';
import 'package:shopping_app/pages/details/details_screen.dart';
import 'package:shopping_app/shared/base/base_view_model.dart';
import 'package:get/get.dart';

class SearchViewModel extends BaseViewModel {
  TextEditingController searchController = TextEditingController();
  FocusNode focusNode = FocusNode();

  String searchText = "";

  final _products = <Product>[].obs;
  List<Product> get products => _products.toList();
  final _isHaveLoadMore = false.obs;
  bool get isHaveLoadMore => _isHaveLoadMore.value;
  int page = 0;

  @override
  void initState() {
    searchController = TextEditingController(text: searchText);
    getData();
    super.initState();
  }

  void getData() {
    if (GetUtils.isNullOrBlank(searchController.text)) {
      _products.assignAll([]);
      return;
    }
    call(() async {
      final Map<String, dynamic> params = {};
      params["keyword"] = searchController.text;
      final productsTemp = await injector<ProductService>().search(params, page ?? 0);

      if (page == 0) {
        _products.assignAll(productsTemp);
      } else {
        _products.addAll(productsTemp);
      }
      page++;
      _isHaveLoadMore.value = !(productsTemp?.isEmpty ?? false);
    });
  }

  void onFollowClicked(int i) {
    call(() async {
      if (products[i]?.isFollow ?? false) {
        await injector<ProductService>().unFollowProduct(products[i].id);
        _products[i].isFollow = false;
      } else {
        await injector<ProductService>().followProduct(products[i].id);
        _products[i].isFollow = true;
      }
      _products.refresh();
      injector<EventBusHelper>().eventBus.fire(UpdateFollowEventBus());
    });
  }

  @override
  void disposeState() {
    _products.close();
    _isHaveLoadMore.close();
    super.disposeState();
  }

  void onItemClicked(int index) {
    gotoProduct(products[index]);
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
}
