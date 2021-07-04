import 'package:flutter/material.dart';
import 'package:shopping_app/common/product_item.dart';
import 'package:shopping_app/generated/assets.gen.dart';
import 'package:shopping_app/helpers/format_helpers.dart';
import 'package:shopping_app/models/product.dart';
import 'package:shopping_app/pages/details/chart/line_chart.dart';
import 'package:shopping_app/shared/view/network_image.dart';
import 'package:shopping_app/theme/ui_color.dart';
import 'package:shopping_app/theme/ui_text_style.dart';

import 'components/body.dart';
import 'package:shopping_app/extensions/size_ext.dart';

class DetailsScreen extends StatefulWidget {
  final Product product;

  const DetailsScreen({this.product});

  @override
  _DetailsScreenState createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width / 100;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        flexibleSpace: Container(
          padding: EdgeInsets.fromLTRB(5.0.w, 14.0.h, 0, 0),
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [Color(0xffF12711), Color(0xffF5AF19)],
            ),
          ),
        ),
        title: Text(
          "Chi tiết sản phẩm",
          style: UITextStyle.mediumBlack_16_w400.copyWith(fontSize: 20, color: Colors.white),
        ),
      ),
      // CustomAppBar(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            NetworkImageWidget(
              url: widget.product?.image,
              width: double.infinity,
              height: 240.0.h,
            ),
            SizedBox(
              height: 16.0.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget?.product?.name ?? "",
                    style: UITextStyle.mediumBlack_16_w400,
                  ),
                  SizedBox(
                    height: 8.0.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            getIcon(),
                            SizedBox(
                              width: 8.0.w,
                            ),
                            Expanded(
                              child: Text(
                                "${FormatHelper.moneyFormat(widget?.product?.price ?? 0)}đ",
                                style: UITextStyle.red_18_w700,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          GestureDetector(
                            behavior: HitTestBehavior.translucent,
                            onTap: () {},
                            child: Icon(
                              Icons.favorite,
                              color: widget?.product?.isFollow ?? false ? Colors.red : Colors.grey,
                              size: 24.0.h,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 8.0.h,
                  ),
                  Row(
                    children: [
                      Text("Ngày cập nhật: ${FormatHelper.formatDateTime(widget?.product?.createdAt, pattern: "dd/MM/yyyy")}", style: UITextStyle.mediumBlack_14_w400, maxLines: 4),
                    ],
                  ),
                  SizedBox(
                    height: 16.0.h,
                  ),
                  LineChartSample1(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget getIcon() {
    if (widget.product.from == "shopee") {
      return Assets.icons.icShopee.image(height: 24.0.h, width: 24.0.h);
    }
    if (widget.product.from == "tiki") {
      return Assets.icons.icTiki.image(height: 24.0.h, width: 24.0.h);
    }
    if (widget.product.from == "lazada") {
      return Assets.icons.icLazada.image(height: 24.0.h, width: 24.0.h);
    }
    return Container();
  }
}

class ProductDetailsArguments {
  final ProductItemInfo product;

  ProductDetailsArguments({@required this.product});
}
