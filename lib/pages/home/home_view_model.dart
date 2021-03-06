import 'package:flutter/material.dart';
import 'package:shopping_app/backend/services/product/product_service.dart';
import 'package:shopping_app/event_bus/event_bus_helper.dart';
import 'package:shopping_app/event_bus/update_follow_event_bus.dart';
import 'package:shopping_app/event_bus/update_home_event_bus.dart';
import 'package:shopping_app/firebase/fcm_manager.dart';
import 'package:shopping_app/generated/assets.gen.dart';
import 'package:shopping_app/injector.dart';
import 'package:shopping_app/models/fluctuation.dart';
import 'package:shopping_app/models/poster.dart';
import 'package:shopping_app/models/product.dart';
import 'package:shopping_app/models/statistic.dart';
import 'package:shopping_app/pages/details/details_screen.dart';
import 'package:shopping_app/pages/home/discount/discount_page.dart';
import 'package:shopping_app/pages/home/suggestions/suggestion_page.dart';
import 'package:shopping_app/pages/home/week/week_page.dart';
import 'package:shopping_app/pages/search/search_page.dart';
import 'package:shopping_app/shared/base/base_view_model.dart';
import 'package:get/get.dart';
import 'package:shopping_app/extensions/size_ext.dart';

class HomeViewModel extends BaseViewModel {
  final _products = <Product>[].obs;
  List<Product> get products => _products.toList();
  final _poster = Poster().obs;
  Poster get poster => _poster.value;
  final _maxSaleWeek = <Product>[].obs;
  List<Product> get maxSaleWeek => _maxSaleWeek.toList();
  final _statistic = Statistic().obs;
  Statistic get statistic => _statistic.value;
  final _suggestions = <Product>[].obs;
  List<Product> get suggestions => _suggestions.toList();

  final _fluctuation = <Fluctuation>[].obs;
  List<Fluctuation> get fluctuation => _fluctuation.toList();

  @override
  void initState() {
    injector<FCMManager>().configNotification(Get.context);
    injector<FCMManager>().registerFcmToken();
    getData();
    setupEventBus();
    super.initState();
  }

  void setupEventBus() {
    injector<EventBusHelper>().eventBus.on<UpdateHomeEventBus>().listen((event) {
      getData(isLoad: false);
    });
  }

  void getData({bool isLoad = true}) {
    call(() async {
      _products.assignAll(await injector<ProductService>().getListLastItem());
      _fluctuation.assignAll(await injector<ProductService>().fluctuation(0));
      _maxSaleWeek.assignAll(await injector<ProductService>().saleWeek(0));
      _suggestions.assignAll(await injector<ProductService>().suggestion(0));
      _poster.value = await injector<ProductService>().getPoster();
      _statistic.value = await injector<ProductService>().statistic();
    }, background: !isLoad);
  }

  void onFollowClicked(Product product) {
    call(() async {
      if (product?.isFollow ?? false) {
        await injector<ProductService>().unFollowProduct(product.id);
        updateFollow(product, value: false);
      } else {
        await injector<ProductService>().followProduct(product.id);
        updateFollow(product, value: true);
      }
      injector<EventBusHelper>().eventBus.fire(UpdateFollowEventBus());
    });
  }

  void updateFollow(Product product, {bool value = false}) {
    for (int i = 0; i < products.length; ++i) {
      if (products[i].link == product.link) {
        products[i].isFollow = value;
      }
    }
    for (int i = 0; i < maxSaleWeek.length; ++i) {
      if (maxSaleWeek[i].link == product.link) {
        maxSaleWeek[i].isFollow = value;
      }
    }
    for (int i = 0; i < suggestions.length; ++i) {
      if (suggestions[i].link == product.link) {
        suggestions[i].isFollow = value;
      }
    }
    for (int i = 0; i < fluctuation.length; ++i) {
      if (fluctuation[i].product.link == product.link) {
        fluctuation[i].product.isFollow = value;
      }
    }
    _products.refresh();
    _maxSaleWeek.refresh();
    _suggestions.refresh();
    _fluctuation.refresh();
  }

  @override
  void disposeState() {
    _products.close();
    _poster.close();
    _fluctuation.close();
    _maxSaleWeek.close();
    _statistic.close();
    _suggestions.close();
    super.disposeState();
  }

  void onSearchClicked(String text) {
    Get.to(
      SearchPage(
        searchText: text,
      ),
    );
  }

  Future<void> trackProduct(Product product) async {
    await injector<ProductService>().track(product.id);
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

  void gotoProduct(Product product) {
    trackProduct(product);
    Get.to(
      DetailsScreen(
        product: product,
      ),
      preventDuplicates: false,
    );
  }

  void onDayMoreClicked() {
    Get.to(DiscountPage());
  }

  void onWeekMoreClicked() {
    Get.to(WeekPage());
  }

  void onSuggestionMoreClicked() {
    Get.to(SuggestionPage());
  }
}
