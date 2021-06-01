import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shopping_app/common/product_item.dart';
import 'package:shopping_app/theme/ui_color.dart';
import 'package:shopping_app/theme/ui_text_style.dart';

class FavoriteList extends StatefulWidget {
  @override
  FavoriteListState createState() {
    return FavoriteListState();
  }
}

class FavoriteListState extends State<FavoriteList> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height / 100;
    return Scaffold(
        appBar: AppBar(
            automaticallyImplyLeading: false,
            flexibleSpace: Container(
              padding: EdgeInsets.fromLTRB(0, 40, 0, 0),
              decoration: BoxDecoration(
                  gradient: LinearGradient(begin: Alignment.topRight, end: Alignment.bottomLeft, colors: [UIColor.orange, UIColor.yellow])),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Sản phẩm yêu thích",
                    style: UITextStyle.mediumBlack_16_w400.copyWith(fontSize: 20, color: Colors.white),
                  )
                ],
              ),
            )),
        body: SafeArea(
            child: Container(
          height: height * 100,
          child: ListView.builder(
              itemCount: 5,
              itemBuilder: (context, index) {
                return ProductItem(true);
              }),
        )));
  }
}
