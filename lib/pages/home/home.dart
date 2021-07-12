import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopping_app/common/searchbar.dart';
import 'package:shopping_app/pages/home/home_view_model.dart';
import 'package:shopping_app/pages/home/product_item_widget.dart';
import 'package:shopping_app/shared/base/base_view_state.dart';
import 'package:shopping_app/theme/ui_color.dart';
import 'package:shopping_app/theme/ui_text_style.dart';
import 'package:shopping_app/extensions/size_ext.dart';

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
    final width = MediaQuery.of(context).size.width / 100;
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
              SizedBox(
                height: 16.0.h,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16.0.w),
                child: Text("Sản phẩm nổi bật", style: UITextStyle.mediumBlack_16_w400),
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
                  onFollowClicked: () => viewModel.onFollowClicked(i),
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
                  onFollowClicked: () => viewModel.onFollowClicked(i + 1),
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

  @override
  HomeViewModel createViewModel() => HomeViewModel();
}
