import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopping_app/models/chart.dart';
import 'package:shopping_app/pages/favoriteList/product_item.dart';
import 'package:shopping_app/generated/assets.gen.dart';
import 'package:shopping_app/helpers/format_helpers.dart';
import 'package:shopping_app/models/product.dart';
import 'package:shopping_app/pages/details/chart/line_chart.dart';
import 'package:shopping_app/pages/details/detail_view_model.dart';
import 'package:shopping_app/pages/home/product_item_widget.dart';
import 'package:shopping_app/shared/base/base_view_state.dart';
import 'package:shopping_app/shared/view/network_image.dart';
import 'package:shopping_app/theme/ui_color.dart';
import 'package:shopping_app/theme/ui_text_style.dart';
import 'package:shopping_app/extensions/size_ext.dart';

class DetailsScreen extends StatefulWidget {
  final Product product;
  final Chart chart;
  final List<Product> products;

  DetailsScreen({this.product, this.chart, this.products});

  @override
  _DetailsScreenState createState() => _DetailsScreenState();
}

class _DetailsScreenState extends BaseViewState<DetailsScreen, DetailViewModel> {
  @override
  void loadArguments() {
    viewModel.product = widget?.product;
    if (widget?.chart != null) {
      viewModel.setChart(widget?.chart);
    }
    if (widget?.products != null) {
      viewModel.setPrds(widget?.products);
    }
    super.loadArguments();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

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
        actions: [
          GestureDetector(
            onTap: viewModel.onReportClicked,
            behavior: HitTestBehavior.translucent,
            child: Padding(
              padding: EdgeInsets.only(right: 8.0.w),
              child: Icon(
                Icons.report,
                size: 24.0.h,
              ),
            ),
          )
        ],
        title: Text(
          "Chi ti???t s???n ph???m",
          style: UITextStyle.white_18_w400,
        ),
      ),
      // CustomAppBar(),
      body: Obx(
        () => RefreshIndicator(
          onRefresh: () async {
            viewModel.getChartData();
            return true;
          },
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 240.0.h,
                  child: NetworkImageWidget(
                    url: widget.product?.image,
                    width: double.infinity,
                    height: 240.0.h,
                  ),
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
                                    "${FormatHelper.moneyFormat(widget?.product?.price ?? 0)}??",
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
                                onTap: viewModel.onFollowPrdClicked,
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
                          Expanded(child: Text("Gi?? cao nh???t", style: UITextStyle.mediumBlack_16_w400)),
                          Text(viewModel.getMaxPrice(), style: UITextStyle.mediumBlack_16_w400),
                        ],
                      ),
                      SizedBox(
                        height: 8.0.h,
                      ),
                      Row(
                        children: [
                          Expanded(child: Text("Gi?? th???p nh???t", style: UITextStyle.mediumBlack_16_w400)),
                          Text(viewModel.getMinPrice(), style: UITextStyle.mediumBlack_16_w400),
                        ],
                      ),
                      SizedBox(
                        height: 8.0.h,
                      ),
                      Row(
                        children: [
                          Expanded(child: Text("Ng??y c???p nh???t ", style: UITextStyle.mediumBlack_16_w400, maxLines: 4)),
                          Text(FormatHelper.formatDateTime(widget?.product?.createdAt, pattern: "dd/MM/yyyy"), style: UITextStyle.mediumBlack_16_w400, maxLines: 4),
                        ],
                      ),
                      SizedBox(
                        height: 16.0.h,
                      ),
                      if (viewModel.isHaveChart())
                        SizedBox(
                          height: 300.0.h,
                          width: double.infinity,
                          child: LineChartSample1(
                            data: viewModel.getLineData(),
                            verticalInterval: viewModel.getVerticalInterval(),
                            horizontalAxisValues: viewModel.calcDateTime(),
                            from: viewModel.getFrom(),
                            unit: viewModel.getUnit(),
                            onOpenClicked: viewModel.openHistoryPage,
                            chart: viewModel.chart,
                          ),
                        )
                      else
                        Container(),
                      SizedBox(
                        height: 16.0.h,
                      ),
                      if ((viewModel.chart?.shopees?.length ?? 0) > 0)
                        GestureDetector(
                          behavior: HitTestBehavior.translucent,
                          onTap: viewModel.onGoToShopeeClicked,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5.0.h),
                                  color: UIColor.yellow,
                                ),
                                padding: EdgeInsets.symmetric(vertical: 8.0.h, horizontal: 8.0.w),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Assets.icons.icShopee.image(height: 18.0.h, width: 18.0.h),
                                        SizedBox(
                                          width: 8.0.w,
                                        ),
                                        Text(
                                          "?????n s???n ph???m tr??n Shopee",
                                          style: UITextStyle.white_16_w400,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 8.0.h,
                              ),
                            ],
                          ),
                        ),
                      if ((viewModel.chart?.tikis?.length ?? 0) > 0)
                        GestureDetector(
                          behavior: HitTestBehavior.translucent,
                          onTap: viewModel.onGoToTikiClicked,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5.0.h),
                              color: Colors.blue,
                            ),
                            padding: EdgeInsets.symmetric(vertical: 8.0.h, horizontal: 8.0.w),
                            child: Row(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(3.0.h),
                                  child: Assets.icons.tiki.image(height: 18.0.h, width: 18.0.h),
                                ),
                                SizedBox(
                                  width: 8.0.w,
                                ),
                                Text(
                                  "?????n s???n ph???m tr??n Tiki",
                                  style: UITextStyle.white_16_w400,
                                ),
                              ],
                            ),
                          ),
                        ),
                      SizedBox(
                        height: 16.0.h,
                      ),
                      Text(
                        "S??? l???n bi???n ?????ng gi??",
                        style: UITextStyle.mediumBlack_16_w700,
                      ),
                      SizedBox(
                        height: 8.0.h,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.0.h),
                          border: Border.all(color: UIColor.mediumLightShadeGray),
                        ),
                        padding: EdgeInsets.symmetric(vertical: 8.0.h, horizontal: 8.0.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 8.0.h,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        "Ngu???n",
                                        style: UITextStyle.mediumBlack_16_w400,
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    Expanded(
                                      child: Text(
                                        "S??? l???n",
                                        style: UITextStyle.mediumBlack_16_w400,
                                        textAlign: TextAlign.center,
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 8.0.h,
                                ),
                                Container(
                                  width: double.infinity,
                                  height: 1.0.h,
                                  color: UIColor.mediumLightShadeGray,
                                ),
                              ],
                            ),
                            if ((viewModel.chart?.shopees?.length ?? 0) > 0)
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 8.0.h,
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          "Shopee",
                                          style: UITextStyle.yellow_16_w400,
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                      Expanded(
                                        child: Text(
                                          viewModel.frequencyPriceShopee().toString(),
                                          style: UITextStyle.yellow_16_w400,
                                          textAlign: TextAlign.center,
                                        ),
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: 8.0.h,
                                  ),
                                ],
                              ),
                            if ((viewModel.chart?.tikis?.length ?? 0) > 0 && (viewModel.chart?.shopees?.length ?? 0) > 0)
                              Container(
                                width: double.infinity,
                                height: 1.0.h,
                                color: UIColor.mediumLightShadeGray,
                              ),
                            if ((viewModel.chart?.tikis?.length ?? 0) > 0)
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 8.0.h,
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          "Tiki",
                                          style: UITextStyle.blue_16_w400,
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                      Expanded(
                                        child: Text(
                                          viewModel.frequencyPriceTiki().toString(),
                                          style: UITextStyle.blue_16_w400,
                                          textAlign: TextAlign.center,
                                        ),
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: 8.0.h,
                                  ),
                                ],
                              ),
                          ],
                        ),
                      ),
                      if ((viewModel.suggestions?.length ?? 0) != 0)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 16.0.h,
                            ),
                            Text(
                              "S???n ph???m g???i ?? cho b???n",
                              style: UITextStyle.mediumBlack_16_w700,
                            ),
                            SizedBox(
                              height: 8.0.h,
                            ),
                            ListView.separated(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: (viewModel?.suggestions?.length ?? 0) > 5 ? 5 : viewModel?.suggestions?.length,
                              separatorBuilder: (context, index) => SizedBox(
                                height: 8.0.h,
                              ),
                              padding: EdgeInsets.zero,
                              itemBuilder: (context, index) => GestureDetector(
                                behavior: HitTestBehavior.translucent,
                                onTap: () {
                                  viewModel.gotoProduct(viewModel.suggestions[index]);
                                },
                                child: ProductItem(
                                  product: viewModel.suggestions[index],
                                  onFollowClicked: () => viewModel.onFollowClicked(index),
                                ),
                              ),
                            ),
                          ],
                        )
                      else
                        Container(),
                      if ((viewModel.products?.length ?? 0) != 0)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 16.0.h,
                            ),
                            Text(
                              "S???n ph???m li??n quan",
                              style: UITextStyle.mediumBlack_16_w700,
                            ),
                            SizedBox(
                              height: 8.0.h,
                            ),
                            ListView.separated(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              padding: EdgeInsets.zero,
                              itemCount: (viewModel?.products?.length ?? 0) > 5 ? 5 : viewModel?.products?.length,
                              separatorBuilder: (context, index) => SizedBox(
                                height: 8.0.h,
                              ),
                              itemBuilder: (context, index) => GestureDetector(
                                behavior: HitTestBehavior.translucent,
                                onTap: () {
                                  viewModel.gotoProduct(viewModel.products[index]);
                                },
                                child: ProductItem(
                                  product: viewModel.products[index],
                                  onFollowClicked: () => viewModel.onFollowClicked(index),
                                ),
                              ),
                            ),
                          ],
                        ),
                      SizedBox(
                        height: 50.0.h,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
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

  @override
  DetailViewModel createViewModel() => DetailViewModel();
}
