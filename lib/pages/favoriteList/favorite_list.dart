import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopping_app/common/product_item.dart';
import 'package:shopping_app/pages/favoriteList/favorite_list_view_model.dart';
import 'package:shopping_app/shared/base/base_view_state.dart';
import 'package:shopping_app/shared/view/easy_list_view.dart';
import 'package:shopping_app/theme/ui_color.dart';
import 'package:shopping_app/theme/ui_text_style.dart';
import 'package:shopping_app/extensions/string_ext.dart';
import 'package:shopping_app/extensions/size_ext.dart';

class FavoriteList extends StatefulWidget {
  @override
  FavoriteListState createState() => FavoriteListState();
}

class FavoriteListState extends BaseViewState<FavoriteList, FavoriteListViewModel> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: UIColor.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
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
          "Sản phẩm yêu thích",
          style: UITextStyle.mediumBlack_16_w400.copyWith(fontSize: 20, color: Colors.white),
        ),
      ),
      body: Obx(
        () => SafeArea(
          child: RefreshIndicator(
            onRefresh: () async {
              viewModel.page = 0;
              viewModel.getData();
              return true;
            },
            child: EasyListView(
              padding: EdgeInsets.only(bottom: 16.0.h),
              loadMore: viewModel.isHaveLoadMore,
              onLoadMore: () {
                viewModel.getData();
              },
              itemCount: viewModel.products?.length ?? 0,
              itemBuilder: (context, index) {
                return ProductItem(
                  product: viewModel.products[index],
                  onFollowClicked: () => viewModel.onUnFollowClicked(index),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  @override
  FavoriteListViewModel createViewModel() => FavoriteListViewModel();
}
