import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:keyboard_service/keyboard_service.dart';
import 'package:shopping_app/pages/favoriteList/product_item.dart';
import 'package:shopping_app/common/searchbar.dart';
import 'package:shopping_app/pages/search/search_view_model.dart';
import 'package:shopping_app/shared/base/base_view_state.dart';
import 'package:shopping_app/shared/view/easy_list_view.dart';
import 'package:shopping_app/theme/ui_color.dart';
import 'package:shopping_app/theme/ui_text_style.dart';
import 'package:shopping_app/extensions/size_ext.dart';

class SearchPage extends StatefulWidget {
  final String searchText;

  const SearchPage({this.searchText});

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends BaseViewState<SearchPage, SearchViewModel> {
  @override
  void loadArguments() {
    viewModel.searchText = widget?.searchText ?? "";
    super.loadArguments();
  }

  @override
  Widget build(BuildContext context) {
    return KeyboardAutoDismiss(
      scaffold: Scaffold(
        backgroundColor: UIColor.white,
        appBar: AppBar(
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
                  return GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap: () => viewModel.onItemClicked(index),
                    child: ProductItem(
                      product: viewModel.products[index],
                      onFollowClicked: () => viewModel.onFollowClicked(index),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  SearchViewModel createViewModel() => SearchViewModel();

  Widget _buildSearchBox() {
    return Row(
      children: [
        Expanded(
          child: SearchBar(
            controller: viewModel.searchController,
            focusNode: viewModel.focusNode,
          ),
        ),
        GestureDetector(
          onTap: () {
            viewModel.page = 0;
            viewModel.getData();
          },
          child: Padding(
            padding: EdgeInsets.all(8.0.h),
            child: Icon(Icons.search, size: 30.0.h, color: Colors.white),
          ),
        )
      ],
    );
  }
}
