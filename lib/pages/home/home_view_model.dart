import 'package:flutter/material.dart';
import 'package:shopping_app/backend/services/product/product_service.dart';
import 'package:shopping_app/event_bus/event_bus_helper.dart';
import 'package:shopping_app/event_bus/update_follow_event_bus.dart';
import 'package:shopping_app/firebase/fcm_manager.dart';
import 'package:shopping_app/generated/assets.gen.dart';
import 'package:shopping_app/injector.dart';
import 'package:shopping_app/models/fluctuation.dart';
import 'package:shopping_app/models/poster.dart';
import 'package:shopping_app/models/product.dart';
import 'package:shopping_app/pages/home/discount/discount_page.dart';
import 'package:shopping_app/pages/search/search_page.dart';
import 'package:shopping_app/shared/base/base_view_model.dart';
import 'package:get/get.dart';
import 'package:shopping_app/extensions/size_ext.dart';

class HomeViewModel extends BaseViewModel {
  final _products = <Product>[].obs;
  List<Product> get products => _products.toList();
  final _poster = Poster().obs;
  Poster get poster => _poster.value;

  final _fluctuation = <Fluctuation>[].obs;
  List<Fluctuation> get fluctuation => _fluctuation.toList();

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
      _fluctuation.assignAll(await injector<ProductService>().fluctuation(0));
      _poster.value = await injector<ProductService>().getPoster();
    });
  }

  void onFollowClicked(Product product) {
    call(() async {
      if (product?.isFollow ?? false) {
        await injector<ProductService>().unFollowProduct(product.id);
        product?.isFollow = false;
      } else {
        await injector<ProductService>().followProduct(product.id);
        product?.isFollow = true;
      }
      _products.refresh();
      injector<EventBusHelper>().eventBus.fire(UpdateFollowEventBus());
    });
  }

  @override
  void disposeState() {
    _products.close();
    _poster.close();
    _fluctuation.close();
    super.disposeState();
  }

  void onSearchClicked(String text) {
    Get.to(
      SearchPage(
        searchText: text,
      ),
    );
  }

  Widget getIcon(Product product) {
    if (product.from == "shopee") {
      return Assets.icons.icShopee.image(height: 24.0.h, width: 24.0.h);
    }
    if (product.from == "tiki") {
      return Assets.icons.icTiki.image(height: 24.0.h, width: 24.0.h);
    }
    if (product.from == "lazada") {
      return Assets.icons.icLazada.image(height: 24.0.h, width: 24.0.h);
    }
    return Container();
  }

  void onMoreClicked() {
    Get.to(DiscountPage());
  }
}
