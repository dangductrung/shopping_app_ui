import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shopping_app/common/column_product.dart';
import 'package:shopping_app/common/searchbar.dart';

import 'discount_banner.dart';

class HomeScreen extends StatefulWidget {
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
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
        Container(
          width: width * 80,
          child: SearchBar(
            controller: _controller,
            focusNode: _focusNode,
          ),
        ),
        Expanded(child: Icon(Icons.notifications, size: 30, color: Colors.white))
      ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height / 100;
    final width = MediaQuery.of(context).size.width / 100;
    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: false,
          flexibleSpace: Container(
            padding: EdgeInsets.fromLTRB(5, 14, 0, 0),
            decoration: BoxDecoration(
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
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              DiscountBanner(),
              // Container(padding: EdgeInsets.all(0),
              //     margin: EdgeInsets.symmetric(vertical: 0, horizontal: 0),
              //     child: Image.asset("assets/imgs/banner.png"),
              //     width: width * 220,
              //     height: height * 12),
              Container(
                padding: EdgeInsets.symmetric(horizontal: width * 5, vertical: width * 2),
                child: Text(
                  "Sản phẩm nổi bật",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.black, letterSpacing: 0.8),
                ),
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 10,
                itemBuilder: (context, index) {
                  return TwoProducts();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
