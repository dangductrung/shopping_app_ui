import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopping_app/common/searchbar.dart';
import 'package:shopping_app/generated/assets.gen.dart';
import 'package:shopping_app/helpers/format_helpers.dart';
import 'package:shopping_app/models/product.dart';
import 'package:shopping_app/pages/details/details_screen.dart';
import 'package:shopping_app/pages/home/home_view_model.dart';
import 'package:shopping_app/pages/home/product_item_widget.dart';
import 'package:shopping_app/shared/base/base_view_state.dart';
import 'package:shopping_app/shared/view/network_image.dart';
import 'package:shopping_app/theme/ui_color.dart';
import 'package:shopping_app/theme/ui_text_style.dart';
import 'package:shopping_app/extensions/size_ext.dart';
import 'package:shopping_app/extensions/date_time_ext.dart';

class HomeScreen extends StatefulWidget {
  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends BaseViewState<HomeScreen, HomeViewModel> {
  TextEditingController _controller;
  FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _focusNode = FocusNode();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _controller.dispose();
    super.dispose();
  }

  Widget _buildSearchBox() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.0.w, vertical: 12.0.h),
      child: Row(
        children: [
          Expanded(
            child: SearchBar(
              controller: _controller,
              focusNode: _focusNode,
            ),
          ),
          GestureDetector(
            onTap: () => viewModel.onSearchClicked(_controller?.text ?? ""),
            child: Padding(
              padding: EdgeInsets.all(8.0.h),
              child: Icon(Icons.search, size: 30.0.h, color: Colors.white),
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      backgroundColor: UIColor.white,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: _buildSearchBox(),
        titleSpacing: 0,
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
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          viewModel.getData();
          return true;
        },
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 8.0.h,
              ),
              Obx(
                () => viewModel.poster?.bgColorStart != null
                    ? Container(
                        margin: EdgeInsets.symmetric(horizontal: 16.0.w),
                        padding: EdgeInsets.symmetric(horizontal: 16.0.w, vertical: 16.0.h),
                        height: 100.0.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.0.h),
                          gradient: LinearGradient(
                            colors: [viewModel.poster?.bgColorStart, viewModel.poster?.bgColorEnd],
                            begin: FractionalOffset.topRight,
                            end: FractionalOffset.bottomLeft,
                          ),
                        ),
                        child: Center(
                          child: AutoSizeText(
                            viewModel.poster?.title,
                            style: TextStyle(
                              color: viewModel.poster.txtColor,
                              fontSize: 20.0.sp,
                              fontWeight: FontWeight.w700,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      )
                    : Container(),
              ),
              Obx(
                () => ((viewModel.statistic?.shopee?.length ?? 0) == 2) && ((viewModel.statistic?.tiki?.length ?? 0) == 2) ? _buildStatistic() : Container(),
              ),
              Obx(
                () => (viewModel.suggestions?.length ?? 0) > 0 ? _buildSuggestionsList() : Container(),
              ),
              Obx(
                () => (viewModel.maxSaleWeek?.length ?? 0) > 0 ? buildMaxFlucWidget() : Container(),
              ),
              Obx(
                () => (viewModel.fluctuation?.length ?? 0) > 0
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 8.0.h,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 8.0.h, horizontal: 16.0.w),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.whatshot,
                                  color: UIColor.red,
                                  size: 20.0.h,
                                ),
                                SizedBox(
                                  width: 2.0.h,
                                ),
                                Expanded(
                                  child: Text("Giảm giá mới trong 24h", style: UITextStyle.mediumBlack_16_w700),
                                ),
                                GestureDetector(
                                  behavior: HitTestBehavior.translucent,
                                  onTap: viewModel.onDayMoreClicked,
                                  child: Text(
                                    "Xem thêm",
                                    style: UITextStyle.blue_16_w400,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 16.0.h,
                          ),
                          _fluctuationList(),
                        ],
                      )
                    : Container(),
              ),
              SizedBox(
                height: 16.0.h,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16.0.w),
                child: Text("Sản phẩm nổi bật", style: UITextStyle.mediumBlack_16_w700),
              ),
              Obx(
                () => buildWidget(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatistic() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0.w),
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 16.0.h),
        decoration: BoxDecoration(
          color: UIColor.lightPinkPastel.withAlpha(90),
        ),
        child: Column(
          children: [
            SizedBox(
              height: 16.0.h,
            ),
            Text(
              "Gợi ý thời gian giảm giá sốc (*)",
              style: UITextStyle.mediumBlack_16_w700,
            ),
            SizedBox(
              height: 16.0.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Assets.icons.icShopee.image(
                        height: 80.0.h,
                      ),
                      SizedBox(
                        height: 8.0.h,
                      ),
                      Text(FormatHelper.formatDateTime(viewModel.statistic.shopee[0], pattern: "dd-MM-yyyy"), style: UITextStyle.mediumBlack_16_w400),
                      SizedBox(
                        height: 4.0.h,
                      ),
                      Text(FormatHelper.formatDateTime(viewModel.statistic.shopee[1], pattern: "dd-MM-yyyy"), style: UITextStyle.mediumBlack_16_w400),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8.0.h),
                        child: Assets.icons.tiki.image(
                          height: 80.0.h,
                        ),
                      ),
                      SizedBox(
                        height: 8.0.h,
                      ),
                      Text(FormatHelper.formatDateTime(viewModel.statistic.tiki[0], pattern: "dd-MM-yyyy"), style: UITextStyle.mediumBlack_16_w400),
                      SizedBox(
                        height: 4.0.h,
                      ),
                      Text(FormatHelper.formatDateTime(viewModel.statistic.tiki[1], pattern: "dd-MM-yyyy"), style: UITextStyle.mediumBlack_16_w400),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 16.0.h,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16.0.w),
              child: Text("(*) Dữ liệu trên mang tính chất tham khảo, ứng dụng đề xuất dựa trên những lần thống kê biến động giá trong quá khứ", style: UITextStyle.mediumBlack_12_w400_italic),
            ),
            SizedBox(
              height: 16.0.h,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSuggestionsList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 8.0.h,
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 8.0.h, horizontal: 16.0.w),
          child: Row(
            children: [
              Icon(
                Icons.whatshot,
                color: UIColor.red,
                size: 20.0.h,
              ),
              SizedBox(
                width: 2.0.h,
              ),
              Expanded(
                child: Text(
                  "Sản phẩm gợi ý cho bạn",
                  style: UITextStyle.mediumBlack_16_w700,
                ),
              ),
              GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: viewModel.onSuggestionMoreClicked,
                child: Text(
                  "Xem thêm",
                  style: UITextStyle.blue_16_w400,
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 8.0.h,
        ),
        _buildSuggestions(),
        SizedBox(
          height: 16.0.h,
        ),
      ],
    );
  }

  Widget _buildSuggestions() {
    final double height = 290.0.h;
    final double width = 170.0.w;
    return SizedBox(
      height: height,
      child: ListView.separated(
        separatorBuilder: (context, index) => SizedBox(
          width: 12.0.w,
        ),
        padding: EdgeInsets.symmetric(horizontal: 24.0.w),
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemCount: viewModel.suggestions?.length ?? 0,
        itemBuilder: (context, index) => GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () {
            viewModel.gotoProduct(viewModel.suggestions[index]);
          },
          child: SizedBox(
            width: width,
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: UIColor.lightGrayBorder),
                borderRadius: BorderRadius.circular(5.0.h),
                color: UIColor.white,
              ),
              child: Column(
                children: [
                  Stack(
                    children: [
                      SizedBox(
                        height: 150.0.h,
                        child: NetworkImageWidget(
                          url: viewModel.suggestions[index]?.image,
                          height: 150.0.h,
                          width: width,
                          boxFit: BoxFit.contain,
                        ),
                      ),
                      Stack(
                        children: [
                          SizedBox(
                            height: 150.0.h,
                            width: 150.0.w,
                            child: NetworkImageWidget(
                              url: viewModel?.suggestions[index]?.image ?? "",
                              height: 150.0.h,
                              width: 100.0.w,
                            ),
                          ),
                          Positioned(
                            child: Container(
                              padding: EdgeInsets.symmetric(vertical: 2.0.h, horizontal: 4.0.w),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(5.0.h),
                                  bottomRight: Radius.circular(5.0.h),
                                ),
                                color: Colors.red,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.whatshot,
                                    color: UIColor.white,
                                    size: 20.0.h,
                                  ),
                                  SizedBox(
                                    width: 4.0.h,
                                  ),
                                  AutoSizeText(
                                    "${viewModel.suggestions[index]?.delta ?? 0}%",
                                    style: UITextStyle.white_14_400,
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 6.0.h,
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.0.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      viewModel.suggestions[index]?.name,
                                      style: UITextStyle.mediumBlack_14_w400,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    SizedBox(
                                      height: 3.0.h,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  viewModel.getIcon(viewModel.suggestions[index]),
                                  AutoSizeText(
                                    "${FormatHelper.moneyFormat(viewModel.suggestions[index]?.price ?? 0)}đ",
                                    style: UITextStyle.red_16_w700,
                                    textAlign: TextAlign.end,
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 2.0.h,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  GestureDetector(
                                    behavior: HitTestBehavior.translucent,
                                    onTap: () {
                                      viewModel.onFollowClicked(viewModel.suggestions[index]);
                                    },
                                    child: Icon(
                                      Icons.favorite,
                                      color: viewModel.suggestions[index]?.isFollow ?? false ? Colors.red : Colors.grey,
                                      size: 24.0.h,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 2.0.h,
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      viewModel.suggestions[index].createdAt.timeAgo(),
                                      style: UITextStyle.mediumLightShadeGray_12_w400,
                                      maxLines: 1,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 4.0.h,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildMaxFlucWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 8.0.h,
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 8.0.h, horizontal: 16.0.w),
          child: Row(
            children: [
              Icon(
                Icons.whatshot,
                color: UIColor.red,
                size: 20.0.h,
              ),
              SizedBox(
                width: 2.0.h,
              ),
              Expanded(
                child: Text(
                  "Giảm giá mạnh trong 7 ngày",
                  style: UITextStyle.mediumBlack_16_w700,
                ),
              ),
              GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: viewModel.onWeekMoreClicked,
                child: Text(
                  "Xem thêm",
                  style: UITextStyle.blue_16_w400,
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 8.0.h,
        ),
        _buildWeekList(),
        SizedBox(
          height: 16.0.h,
        ),
      ],
    );
  }

  Widget _buildWeekList() {
    final double height = 290.0.h;
    final double width = 170.0.w;
    return SizedBox(
      height: height,
      child: ListView.separated(
        separatorBuilder: (context, index) => SizedBox(
          width: 12.0.w,
        ),
        padding: EdgeInsets.symmetric(horizontal: 24.0.w),
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemCount: viewModel.maxSaleWeek?.length ?? 0,
        itemBuilder: (context, index) => GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () {
            viewModel.gotoProduct(viewModel.maxSaleWeek[index]);
          },
          child: SizedBox(
            width: width,
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: UIColor.lightGrayBorder),
                borderRadius: BorderRadius.circular(5.0.h),
                color: UIColor.white,
              ),
              child: Column(
                children: [
                  Stack(
                    children: [
                      SizedBox(
                        height: 150.0.h,
                        child: NetworkImageWidget(
                          url: viewModel.maxSaleWeek[index]?.image,
                          height: 150.0.h,
                          width: width,
                          boxFit: BoxFit.contain,
                        ),
                      ),
                      Stack(
                        children: [
                          SizedBox(
                            height: 150.0.h,
                            width: 150.0.w,
                            child: NetworkImageWidget(
                              url: viewModel?.maxSaleWeek[index]?.image ?? "",
                              height: 150.0.h,
                              width: 100.0.w,
                            ),
                          ),
                          Positioned(
                            child: Container(
                              padding: EdgeInsets.symmetric(vertical: 2.0.h, horizontal: 4.0.w),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(5.0.h),
                                  bottomRight: Radius.circular(5.0.h),
                                ),
                                color: Colors.red,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.whatshot,
                                    color: UIColor.white,
                                    size: 20.0.h,
                                  ),
                                  SizedBox(
                                    width: 4.0.h,
                                  ),
                                  AutoSizeText(
                                    "${viewModel.maxSaleWeek[index]?.delta ?? 0}%",
                                    style: UITextStyle.white_14_400,
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 6.0.h,
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.0.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      viewModel.maxSaleWeek[index]?.name,
                                      style: UITextStyle.mediumBlack_14_w400,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    SizedBox(
                                      height: 3.0.h,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  viewModel.getIcon(viewModel.maxSaleWeek[index]),
                                  AutoSizeText(
                                    "${FormatHelper.moneyFormat(viewModel.maxSaleWeek[index]?.price ?? 0)}đ",
                                    style: UITextStyle.red_16_w700,
                                    textAlign: TextAlign.end,
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 2.0.h,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  GestureDetector(
                                    behavior: HitTestBehavior.translucent,
                                    onTap: () {
                                      viewModel.onFollowClicked(viewModel.maxSaleWeek[index]);
                                    },
                                    child: Icon(
                                      Icons.favorite,
                                      color: viewModel.maxSaleWeek[index]?.isFollow ?? false ? Colors.red : Colors.grey,
                                      size: 24.0.h,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 2.0.h,
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: AutoSizeText(
                                      viewModel.maxSaleWeek[index].createdAt.timeAgo(),
                                      style: UITextStyle.mediumLightShadeGray_12_w400,
                                      maxLines: 1,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 4.0.h,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildWidget() {
    final List<Widget> items = [];
    for (int i = 0; i < (viewModel.products?.length ?? 0); i = i + 2) {
      final Widget row = Row(
        children: [
          if (i < (viewModel.products?.length ?? 0))
            Expanded(
              child: GestureDetector(
                behavior: HitTestBehavior.translucent,
                child: ProductItemWidget(
                  product: viewModel.products[i],
                  onFollowClicked: () => viewModel.onFollowClicked(viewModel.products[i]),
                  onProductClicked: () => viewModel.gotoProduct(viewModel.products[i]),
                ),
              ),
            ),
          SizedBox(
            width: 10.0.w,
          ),
          if ((i + 1) < (viewModel.products?.length ?? 0))
            Expanded(
              child: GestureDetector(
                behavior: HitTestBehavior.translucent,
                child: ProductItemWidget(
                  product: viewModel.products[i + 1],
                  onFollowClicked: () => viewModel.onFollowClicked(viewModel.products[i + 1]),
                  onProductClicked: () => viewModel.gotoProduct(viewModel.products[i + 1]),
                ),
              ),
            ),
        ],
      );
      items.add(row);
    }
    return ListView.separated(
      padding: EdgeInsets.symmetric(vertical: 16.0.h, horizontal: 16.0.w),
      separatorBuilder: (context, index) => SizedBox(
        height: 16.0.h,
      ),
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: ((viewModel.products?.length ?? 0) / 2).ceil(),
      itemBuilder: (context, index) {
        return items[index];
      },
    );
  }

  Widget _fluctuationList() {
    final double height = 280.0.h;
    final double width = 170.0.w;
    return SizedBox(
      height: height,
      child: ListView.separated(
        separatorBuilder: (context, index) => SizedBox(
          width: 12.0.w,
        ),
        padding: EdgeInsets.symmetric(horizontal: 24.0.w),
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemCount: viewModel.fluctuation?.length ?? 0,
        itemBuilder: (context, index) => GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () {
            viewModel.gotoProduct(viewModel.fluctuation[index].product);
          },
          child: Stack(
            children: [
              SizedBox(
                width: width,
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: UIColor.lightGrayBorder),
                    borderRadius: BorderRadius.circular(5.0.h),
                    color: UIColor.white,
                  ),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 150.0.h,
                        child: NetworkImageWidget(
                          url: viewModel.fluctuation[index].product?.image,
                          height: 150.0.h,
                          width: width,
                          boxFit: BoxFit.contain,
                        ),
                      ),
                      SizedBox(
                        height: 6.0.h,
                      ),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8.0.w),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          viewModel.fluctuation[index].product?.name,
                                          style: UITextStyle.mediumBlack_14_w400,
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        SizedBox(
                                          height: 3.0.h,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      viewModel.getIcon(viewModel.fluctuation[index].product),
                                      AutoSizeText(
                                        "${FormatHelper.moneyFormat(viewModel.fluctuation[index].product?.price ?? 0)}đ",
                                        style: UITextStyle.red_16_w700,
                                        textAlign: TextAlign.end,
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 8.0.h,
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: AutoSizeText(
                                          viewModel.fluctuation[index].product.createdAt.timeAgo(),
                                          style: UITextStyle.mediumLightShadeGray_12_w400,
                                          maxLines: 1,
                                        ),
                                      ),
                                      GestureDetector(
                                        behavior: HitTestBehavior.translucent,
                                        onTap: () {
                                          viewModel.onFollowClicked(viewModel.fluctuation[index]?.product);
                                        },
                                        child: Icon(
                                          Icons.favorite,
                                          color: viewModel.fluctuation[index].product?.isFollow ?? false ? Colors.red : Colors.grey,
                                          size: 24.0.h,
                                        ),
                                      ),
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
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                right: 0.0.w,
                top: 0.0.h,
                child: Container(
                  height: 28.0.h,
                  width: 50.0.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(14.0.h), bottomLeft: Radius.circular(14.0.h)),
                    color: UIColor.red,
                  ),
                  padding: EdgeInsets.only(left: 4.0.w),
                  child: Center(
                    child: AutoSizeText(
                      "${viewModel.fluctuation[index]?.delta ?? 0}%",
                      style: UITextStyle.white_14_400,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  HomeViewModel createViewModel() => HomeViewModel();
}
