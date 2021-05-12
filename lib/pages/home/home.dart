import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shopping_app/common/product_thumb.dart';
import 'package:shopping_app/common/searchbar.dart';

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
              children: [
                _buildSearchBox(),
              ],
            ),
          )),
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
                margin: EdgeInsets.symmetric(vertical: 0, horizontal: 0),
                child: Image.asset("assets/imgs/banner.png"),
                width: width * 200,
                height: height * 16),
            Container(
                width: width * 100,
                height: height * 39,
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                color: Colors.red.shade900,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      child: Text(
                        "Sản phẩm nổi bật",
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.white, letterSpacing: 0.8),
                      ),
                    ),
                    Container(
                      height: height * 30,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: 10,
                        itemBuilder: (context, index) {
                          return ProductThumb();
                        },
                      ),
                    ),
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
