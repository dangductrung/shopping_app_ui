import 'package:flutter/material.dart';
import 'package:shopping_app/backend/services/product/product_service.dart';
import 'package:shopping_app/injector.dart';
import 'package:shopping_app/models/history_product.dart';
import 'package:shopping_app/models/product.dart';
import 'package:shopping_app/shared/base/base_view_model.dart';
import 'package:get/get.dart';
import 'package:shopping_app/theme/ui_color.dart';
import 'package:shopping_app/theme/ui_text_style.dart';

class HistoryPrdViewModel extends BaseViewModel {
  Product product;
  final _history = <HistoryProduct>[].obs;
  List<HistoryProduct> get history => _history.toList();

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  void disposeState() {
    _history.close();
    super.disposeState();
  }

  void getData() {
    call(() async {
      _history.assignAll(await injector<ProductService>().history(product?.id));
      _history.refresh();
    });
  }

  String getDelta(int index) {
    String result = "";
    if (history[index].delta == 0) {
      result = history[index].delta.toString();
    } else if (history[index].delta > 0) {
      result = "+${history[index].delta.toString()}";
    } else {
      result = history[index].delta.toString();
    }
    return result;
  }

  TextStyle getColor(int index) {
    TextStyle result = UITextStyle.mediumBlack_16_w400;
    if (history[index].delta == 0) {
      result = UITextStyle.mediumBlack_16_w400;
    } else if (history[index].delta > 0) {
      result = UITextStyle.green_16_w400;
    } else {
      result = UITextStyle.red_16_w400;
    }
    return result;
  }
}
