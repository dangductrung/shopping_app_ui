import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:shopping_app/backend/services/product/product_service.dart';
import 'package:shopping_app/event_bus/event_bus_helper.dart';
import 'package:shopping_app/event_bus/update_follow_event_bus.dart';
import 'package:shopping_app/helpers/format_helpers.dart';
import 'package:shopping_app/injector.dart';
import 'package:shopping_app/models/chart.dart';
import 'package:shopping_app/models/product.dart';
import 'package:shopping_app/pages/details/details_screen.dart';
import 'package:shopping_app/pages/history_prd/history_prd_page.dart';
import 'package:shopping_app/pages/report/report_page.dart';
import 'package:shopping_app/shared/base/base_view_model.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:fl_chart/fl_chart.dart';

class DetailViewModel extends BaseViewModel {
  Product product;

  final _chart = Chart().obs;
  final _products = <Product>[].obs;
  Chart get chart => _chart.value;
  List<Product> get products => _products.toList();
  final _suggestions = <Product>[].obs;
  List<Product> get suggestions => _suggestions.toList();

  void onReportClicked() {
    Get.to(ReportPage(
      id: product?.id,
    ));
  }

  // ignore: use_setters_to_change_properties
  void setChart(Chart chart) {
    _chart.value = chart;
  }

  // ignore: use_setters_to_change_properties
  void setPrds(List<Product> products) {
    _products.assignAll(products);
  }

  Future<void> onOpenBrowserClicked() async {
    if (await canLaunch(product?.link)) {
      await launch(product?.link);
    } else {
      throw 'Could not launch ${product?.link}';
    }
  }

  @override
  void initState() {
    getChartData();
    super.initState();
  }

  void getChartData() {
    call(() async {
      _suggestions.assignAll(await injector<ProductService>().suggestion(0));
      _suggestions.removeWhere((element) => element.link == product.link);
      _chart.value = await injector<ProductService>().getChartData(product?.id);
      final Map<String, dynamic> params = {};
      params["keyword"] = product?.name;
      _products.assignAll(await injector<ProductService>().search(params, 0));
      _products.removeWhere((element) => element.link == product.link);
      _chart.refresh();
      _products.refresh();
    });
  }

  List<DateTime> calcDateTime() {
    final List<DateTime> dates = [];
    for (int i = 0; i < (chart?.shopees?.length ?? 0); ++i) {
      dates.add(chart.shopees[i].createdAt);
    }
    for (int i = 0; i < (chart?.tikis?.length ?? 0); ++i) {
      if (dates.firstWhere((element) => element == chart.tikis[i].createdAt, orElse: () => null) == null) {
        dates.add(chart.tikis[i].createdAt);
      }
    }
    dates.add(DateTime.now());
    dates.sort((a, b) => a.compareTo(b));
    return dates;
  }

  List<String> getFrom() {
    final List<String> from = [];
    if ((chart?.shopees?.length ?? 0) > 0) {
      from.add("shopee");
    }
    if ((chart?.tikis?.length ?? 0) > 0) {
      from.add("tiki");
    }
    return from;
  }

  List<List<FlSpot>> getLineData() {
    final List<DateTime> dates = calcDateTime();
    final List<List<FlSpot>> result = [];

    if ((chart?.shopees?.length ?? 0) > 0) {
      final List<FlSpot> temp = [];

      for (int i = 0; i < dates.length; ++i) {
        if (chart.shopees.firstWhere((element) => element.createdAt == dates[i], orElse: () => null) == null) {
          if (dates[i].difference(chart.shopees[0].createdAt).inSeconds < 0) {
            temp.add(FlSpot(dates[i].millisecondsSinceEpoch.toDouble(), chart.shopees[0].price));
          } else if ((chart.shopees?.length ?? 0) > 1 && dates[i].difference(chart.shopees[chart.shopees.length - 1].createdAt).inSeconds > 0) {
            temp.add(FlSpot(dates[i].millisecondsSinceEpoch.toDouble(), chart.shopees[chart.shopees.length - 1].price));
          } else {
            final Product product = chart.shopees.firstWhere((element) => dates[i].difference(element.createdAt).inSeconds > 0, orElse: () => null);
            temp.add(FlSpot(dates[i].millisecondsSinceEpoch.toDouble(), product.price));
          }
        } else {
          temp.add(FlSpot(dates[i].millisecondsSinceEpoch.toDouble(), chart.shopees.firstWhere((element) => element.createdAt == dates[i], orElse: () => null).price));
        }
      }
      temp.add(FlSpot(DateTime.now().millisecondsSinceEpoch.toDouble(), chart.shopees[chart.shopees.length - 1].price));

      result.add(temp);
    }

    if ((chart?.tikis?.length ?? 0) > 0) {
      final List<FlSpot> temp = [];
      for (int i = 0; i < dates.length; ++i) {
        if (chart.tikis.firstWhere((element) => element.createdAt == dates[i], orElse: () => null) == null) {
          if (dates[i].difference(chart.tikis[0].createdAt).inSeconds < 0) {
            temp.add(FlSpot(dates[i].millisecondsSinceEpoch.toDouble(), chart.tikis[0].price));
          } else if ((chart.tikis?.length ?? 0) > 1 && dates[i].difference(chart.tikis[chart.tikis.length - 1].createdAt).inSeconds > 0) {
            temp.add(FlSpot(dates[i].millisecondsSinceEpoch.toDouble(), chart.tikis[chart.tikis.length - 1].price));
          } else {
            final Product product = chart.tikis.firstWhere((element) => dates[i].difference(element.createdAt).inSeconds > 0, orElse: () => null);
            temp.add(FlSpot(dates[i].millisecondsSinceEpoch.toDouble(), product.price));
          }
        } else {
          temp.add(FlSpot(dates[i].millisecondsSinceEpoch.toDouble(), chart.tikis.firstWhere((element) => element.createdAt == dates[i], orElse: () => null).price));
        }
      }
      temp.add(FlSpot(DateTime.now().millisecondsSinceEpoch.toDouble(), chart.tikis[chart.tikis.length - 1].price));
      result.add(temp);
    }
    return result;
  }

  bool isHaveChart() {
    return ((chart?.shopees?.length ?? 0) != 0 || (chart?.tikis?.length ?? 0) != 0) && ((calcDateTime()?.length ?? 0) != 0);
  }

  String getUnit() {
    if (getVerticalInterval() < 1000) {
      return "đồng";
    } else if (getVerticalInterval() < 1000000) {
      return "nghìn đồng";
    } else if (getVerticalInterval() < 1000000000) {
      return "triệu đồng";
    } else if (getVerticalInterval() < 1000000000000) {
      return "tỉ đồng";
    }
    return "";
  }

  double getVerticalInterval() {
    double shopeePrice = 0;
    double tikiPrice = 0;
    if ((chart?.shopees?.length ?? 0) != 0) {
      shopeePrice = chart.shopees[0].price;

      for (int i = 0; i < (chart.shopees?.length ?? 0); ++i) {
        if (chart.shopees[i].price > shopeePrice) {
          shopeePrice = chart.shopees[i].price;
        }
      }
    }
    if ((chart?.tikis?.length ?? 0) != 0) {
      tikiPrice = chart.tikis[0].price;

      for (int i = 0; i < (chart.tikis?.length ?? 0); ++i) {
        if (chart.tikis[i].price > tikiPrice) {
          tikiPrice = chart.tikis[i].price;
        }
      }
    }

    final double price = shopeePrice > tikiPrice ? shopeePrice : tikiPrice;

    if (price < 10000) {
      return 1000;
    } else if (price < 100000) {
      return 10000;
    } else if (price < 1000000) {
      return 100000;
    } else if (price < 10000000) {
      return 1000000;
    } else {
      return 10000000;
    }
  }

  String getMaxPrice() {
    if ((chart?.shopees?.length ?? 0) == 0 && (chart?.tikis?.length ?? 0) == 0) {
      return "";
    }
    if ((chart?.shopees?.length ?? 0) != 0) {
      if (chart?.shopees[0].link == product?.link) {
        double maxPrice = chart?.shopees[0].price;

        for (int i = 1; i < chart?.shopees?.length; ++i) {
          if (chart?.shopees[i].price > maxPrice) {
            maxPrice = chart?.shopees[i].price;
          }
        }

        return "${FormatHelper.moneyFormat(maxPrice)}đ";
      }
    }
    if ((chart?.tikis?.length ?? 0) != 0) {
      if (chart?.tikis[0].link == product?.link) {
        double maxPrice = chart?.tikis[0].price;

        for (int i = 1; i < chart?.tikis?.length; ++i) {
          if (chart?.tikis[i].price > maxPrice) {
            maxPrice = chart?.tikis[i].price;
          }
        }

        return "${FormatHelper.moneyFormat(maxPrice)}đ";
      }
    }
    return "";
  }

  String getMinPrice() {
    if ((chart?.shopees?.length ?? 0) == 0 && (chart?.tikis?.length ?? 0) == 0) {
      return "";
    }
    if ((chart?.shopees?.length ?? 0) != 0) {
      if (chart?.shopees[0].link == product?.link) {
        double minPrice = chart?.shopees[0].price;

        for (int i = 1; i < chart?.shopees?.length; ++i) {
          if (chart?.shopees[i].price < minPrice) {
            minPrice = chart?.shopees[i].price;
          }
        }

        return "${FormatHelper.moneyFormat(minPrice)}đ";
      }
    }
    if ((chart?.tikis?.length ?? 0) != 0) {
      if (chart?.tikis[0].link == product?.link) {
        double minPrice = chart?.tikis[0].price;

        for (int i = 1; i < chart?.tikis?.length; ++i) {
          if (chart?.tikis[i].price < minPrice) {
            minPrice = chart?.tikis[i].price;
          }
        }

        return "${FormatHelper.moneyFormat(minPrice)}đ";
      }
    }
    return "";
  }

  @override
  void disposeState() {
    _chart.close();
    _products.close();
    _suggestions.close();
    super.disposeState();
  }

  void onFollowClicked(int index) {
    call(() async {
      if (products[index]?.isFollow ?? false) {
        await injector<ProductService>().unFollowProduct(products[index].id);
        _products[index].isFollow = false;
      } else {
        await injector<ProductService>().followProduct(products[index].id);
        _products[index].isFollow = true;
      }
      _products.refresh();
      injector<EventBusHelper>().eventBus.fire(UpdateFollowEventBus());
    });
  }

  Future<void> onGoToShopeeClicked() async {
    final url = Uri.encodeFull(chart.shopees[0].link);

    if (await canLaunch(url)) {
      try {
        await launch(
          url,
          forceSafariVC: false,
          forceWebView: false,
        );
      } catch (e) {
        debugPrint(e.toString());
      }
    } else {
      throw 'Could not launch ${chart.shopees[0].link}';
    }
  }

  Future<void> onGoToTikiClicked() async {
    final url = Uri.encodeFull(chart.tikis[0].link);

    if (await canLaunch(url)) {
      try {
        await launch(
          url,
          forceSafariVC: false,
          forceWebView: false,
        );
      } catch (e) {
        debugPrint(e.toString());
      }
    } else {
      throw 'Could not launch ${chart.tikis[0].link}';
    }
  }

  int frequencyPriceShopee() {
    return (chart?.shopees?.length ?? 0) != 0 ? chart.shopees.length - 1 : 0;
  }

  int frequencyPriceTiki() {
    return (chart?.tikis?.length ?? 0) != 0 ? chart.tikis.length - 1 : 0;
  }

  void onFollowPrdClicked() {
    call(() async {
      if (product?.isFollow ?? false) {
        await injector<ProductService>().unFollowProduct(product.id);
        product.isFollow = false;
      } else {
        await injector<ProductService>().followProduct(product.id);
        product.isFollow = true;
      }
      final Map<String, dynamic> params = {};
      params["keyword"] = product?.name;
      _products.assignAll(await injector<ProductService>().search(params, 0));
      injector<EventBusHelper>().eventBus.fire(UpdateFollowEventBus());
    });
  }

  void openHistoryPage() {
    Get.to(
      HistoryPrdPage(
        product: product,
      ),
    );
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
