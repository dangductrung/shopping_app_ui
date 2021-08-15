import 'package:shopping_app/backend/services/product/product_service.dart';
import 'package:shopping_app/event_bus/event_bus_helper.dart';
import 'package:shopping_app/event_bus/update_follow_event_bus.dart';
import 'package:shopping_app/event_bus/update_home_event_bus.dart';
import 'package:shopping_app/injector.dart';
import 'package:shopping_app/models/product.dart';
import 'package:shopping_app/models/product.dart';
import 'package:shopping_app/pages/details/details_screen.dart';
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
    setupEventBus();
    super.initState();
  }

  void setupEventBus() {
    injector<EventBusHelper>().eventBus.on<UpdateFollowEventBus>().listen((event) {
      page = 0;
      getData(isLoad: false);
    });
  }

  void getData({bool isLoad = true}) {
    call(() async {
      final productsTemp = await injector<ProductService>().getFollowList(page ?? 0);

      if (page == 0) {
        _products.assignAll(productsTemp);
      } else {
        _products.addAll(productsTemp);
      }
      page++;
      _isHaveLoadMore.value = !(productsTemp?.isEmpty ?? false);
    }, background: !isLoad);
  }

  void onUnFollowClicked(int index) {
    call(() async {
      await injector<ProductService>().unFollowProduct(products[index].id);
      _products.removeAt(index);
      injector<EventBusHelper>().eventBus.fire(UpdateHomeEventBus());
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
