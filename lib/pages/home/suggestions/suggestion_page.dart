import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopping_app/pages/favoriteList/product_item.dart';
import 'package:shopping_app/pages/home/suggestions/suggestion_view_model.dart';
import 'package:shopping_app/shared/base/base_view_state.dart';
import 'package:shopping_app/shared/view/easy_list_view.dart';
import 'package:shopping_app/theme/ui_color.dart';
import 'package:shopping_app/theme/ui_text_style.dart';
import 'package:shopping_app/extensions/size_ext.dart';

class SuggestionPage extends StatefulWidget {
  @override
  _SuggestionPageState createState() => _SuggestionPageState();
}

class _SuggestionPageState extends BaseViewState<SuggestionPage, SuggestionViewModel> {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      backgroundColor: UIColor.white,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(
          "Gợi ý cho bạn",
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
            itemCount: viewModel.products?.length ?? 0,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () => viewModel.onItemClicked(index),
                behavior: HitTestBehavior.translucent,
                child: ProductItem(
                  product: viewModel.products[index],
                  onFollowClicked: () => viewModel.onFollowClicked(index),
                  delta: viewModel.products[index].delta ?? 0,
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  @override
  SuggestionViewModel createViewModel() => SuggestionViewModel();
}
