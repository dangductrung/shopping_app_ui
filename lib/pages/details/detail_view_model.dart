import 'package:get/get.dart';
import 'package:shopping_app/backend/services/product/product_service.dart';
import 'package:shopping_app/injector.dart';
import 'package:shopping_app/models/chart.dart';
import 'package:shopping_app/models/product.dart';
import 'package:shopping_app/pages/details/details_screen.dart';
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

  void onReportClicked() {
    Get.to(ReportPage(
      id: product?.id,
    ));
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
      _chart.value = await injector<ProductService>().getChartData(product?.id);
      final Map<String, dynamic> params = {};
      params["keyword"] = product?.name;
      _products.assignAll(await injector<ProductService>().search(params, 0));
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

    dates.sort((a, b) => a.compareTo(b));
    return dates;
  }

  List<String> getFrom() {
    List<String> from = [];
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
      result.add(temp);
    }
    return result;
  }

  bool isHaveChart() {
    return ((chart?.shopees?.length ?? 0) != 0 || (chart?.tikis?.length ?? 0) != 0) && ((calcDateTime()?.length ?? 0) != 0);
  }

  double getVerticalInterval() {
    double shopeePrice = 99999999999;
    double tikiPrice = 99999999999;
    if ((chart?.shopees?.length ?? 0) != 0) {
      shopeePrice = chart.shopees[0].price;
    }
    if ((chart?.tikis?.length ?? 0) != 0) {
      tikiPrice = chart.shopees[0].price;
    }

    double price = shopeePrice > tikiPrice ? shopeePrice : tikiPrice;

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

  @override
  void disposeState() {
    _chart.close();
    _products.close();
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
    });
  }

  Future<void> onGoToShopeeClicked() async {
    if (await canLaunch(chart.shopees[0].link)) {
      await launch(chart.shopees[0].link);
    } else {
      throw 'Could not launch ${chart.shopees[0].link}';
    }
  }

  Future<void> onGoToTikiClicked() async {
    if (await canLaunch(chart.tikis[0].link)) {
      await launch(chart.tikis[0].link);
    } else {
      throw 'Could not launch ${chart.shopees[0].link}';
    }
  }
}
