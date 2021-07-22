import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopping_app/pages/favoriteList/product_item.dart';
import 'package:shopping_app/pages/home/discount/discount_view_model.dart';
import 'package:shopping_app/shared/base/base_view_state.dart';
import 'package:shopping_app/shared/view/easy_list_view.dart';
import 'package:shopping_app/theme/ui_color.dart';
import 'package:shopping_app/theme/ui_text_style.dart';
import 'package:shopping_app/extensions/size_ext.dart';

class DiscountPage extends StatefulWidget {
  @override
  _DiscountPageState createState() => _DiscountPageState();
}

class _DiscountPageState extends BaseViewState<DiscountPage, DiscountViewModel> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: UIColor.white,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(
          "Sản phẩm giảm giá mới",
          style: UITextStyle.white_18_w400,
        ),
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
      body: Obx(
        () => RefreshIndicator(
          onRefresh: () async {
            viewModel.refresh();
            return true;
          },
          child: EasyListView(
            padding: EdgeInsets.only(bottom: 32.0.h),
            loadMore: viewModel.isHaveLoadMore,
            onLoadMore: () {
              viewModel.getData();
            },
            itemCount: viewModel.fluctuation?.length ?? 0,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () => viewModel.onItemClicked(index),
                behavior: HitTestBehavior.translucent,
                child: ProductItem(
                  product: viewModel.fluctuation[index].product,
                  onFollowClicked: () => viewModel.onFollowClicked(index),
                  delta: viewModel.fluctuation[index].delta ?? 0,
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  @override
  DiscountViewModel createViewModel() => DiscountViewModel();
}
