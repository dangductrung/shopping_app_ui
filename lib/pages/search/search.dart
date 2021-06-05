import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shopping_app/common/product_item.dart';
import 'package:shopping_app/common/searchbar.dart';
import 'package:shopping_app/theme/ui_color.dart';

class SearchTab extends StatefulWidget {
  @override
  _SearchTabState createState() {
    return _SearchTabState();
  }
}

class _SearchTabState extends State<SearchTab> {
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
      child: Row(children: [
        Container(
          margin: EdgeInsets.symmetric(horizontal: 5),
          width: width * 92,
          child: SearchBar(
            controller: _controller,
            focusNode: _focusNode,
          ),
        ),
      ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height / 100;
    return Scaffold(
        appBar: AppBar(
            automaticallyImplyLeading: false,
            flexibleSpace: Container(
              padding: EdgeInsets.fromLTRB(0, 14, 0, 0),
              decoration: BoxDecoration(
                  gradient: LinearGradient(begin: Alignment.topRight, end: Alignment.bottomLeft, colors: [UIColor.orange, UIColor.yellow])),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  _buildSearchBox(),
                ],
              ),
            )),
        body: SafeArea(
            child: Container(
          height: height * 100,
          child: ListView.builder(
              itemCount: 20,
              itemBuilder: (context, index) {
                return ProductItem(false);
              }),
        )));
  }
}
