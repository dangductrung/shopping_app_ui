import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopping_app/common/product_item.dart';
import 'package:shopping_app/common/searchbar.dart';
import 'package:shopping_app/pages/home/home_view_model.dart';
import 'package:shopping_app/pages/home/product_item_widget.dart';
import 'package:shopping_app/shared/base/base_view_model.dart';
import 'package:shopping_app/shared/base/base_view_state.dart';
import 'package:shopping_app/theme/ui_color.dart';
import 'package:shopping_app/theme/ui_text_style.dart';

import 'discount_banner.dart';

class HomeScreen extends StatefulWidget {
  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends BaseViewState<HomeScreen, HomeViewModel> {
  TextEditingController _controller;
  FocusNode _focusNode;
  String _terms = '';

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController()..addListener(_onTextChanged);
    _focusNode = FocusNode();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _controller.dispose();
    super.dispose();
  }

  void _onTextChanged() {
    setState(() {
      _terms = _controller.text;
    });
  }

  Widget _buildSearchBox() {
    final width = MediaQuery.of(context).size.width / 100;
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Row(mainAxisSize: MainAxisSize.max, children: [
        Expanded(
          child: Container(
            child: SearchBar(
              controller: _controller,
              focusNode: _focusNode,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Icon(Icons.search, size: 30, color: Colors.white),
        )
      ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height / 100;
    final width = MediaQuery.of(context).size.width / 100;
    return Scaffold(
      backgroundColor: UIColor.white,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
          automaticallyImplyLeading: false,
          flexibleSpace: Container(
            padding: const EdgeInsets.fromLTRB(5, 14, 0, 0),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [Color(0xffF12711), Color(0xffF5AF19)],
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                _buildSearchBox(),
              ],
            ),
          )),
      body: RefreshIndicator(
        onRefresh: () async {
          viewModel.getData();
          return true;
        },
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DiscountBanner(),
              Container(
                padding: EdgeInsets.symmetric(horizontal: width * 5, vertical: width * 2),
                child: Text("Sản phẩm nổi bật", style: UITextStyle.mediumBlack_15_w600),
              ),
              Obx(
                () => GridView.count(
                  childAspectRatio: 0.6,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
                  crossAxisCount: 2,
                  mainAxisSpacing: 10.0,
                  crossAxisSpacing: 10.0,
                  children: viewModel.products.map((e) {
                    return ProductItemWidget(
                      product: e,
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  HomeViewModel createViewModel() => HomeViewModel();
}
