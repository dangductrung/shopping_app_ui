import 'package:flutter/material.dart';
import 'package:shopping_app/common/product_item.dart';
import 'package:shopping_app/theme/ui_color.dart';
import 'package:shopping_app/theme/ui_text_style.dart';

import 'components/body.dart';

class DetailsScreen extends StatelessWidget {
  String description = "Wireless Controller for PS4™ gives you what you want in your gaming from over precision control your games to sharing …";

  ProductItemInfo item = ProductItemInfo(
      "Bình Hoa Thủy Tinh Trong Suốt Phong Cách Bắc Âu",
      '14.599.000',
      '17.000.000',
      "05/05/2021",
      "shopee",
      "Features:1. Material: Made of high-quality Glass material, non-toxic and tasteless, durable, environmentally friendly and practical.2. Exquisite shape: Stylish and beautiful, can be placed on the coffee table or cabinet to perfectly decorate your home.3. INS style, It is possible to place artificial flowers & Hydroponic real flowers4OCCASION: Suitable for family decoration, wedding decoration, banquet decoration, stage decoration, table decoration, etc.5. Pls Attention ! : Glass processing problems, there may be small protrusions or small bubbles on the vase, please understand that this is normal!",
      "assets/imgs/a.jpg",
      true);
  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width / 100;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: Container(
          margin: EdgeInsets.symmetric(horizontal: w * 5),
          child: IconButton(
            icon: Icon(Icons.arrow_back_ios, color: Colors.white, size: 22),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        automaticallyImplyLeading: false,
        flexibleSpace: Container(
          padding: EdgeInsets.fromLTRB(0, 40, 0, 0),
          decoration:
              BoxDecoration(gradient: LinearGradient(begin: Alignment.topRight, end: Alignment.bottomLeft, colors: [UIColor.orange, UIColor.yellow])),
        ),
        title: Text(
          "Chi tiết sản phẩm",
          style: UITextStyle.mediumBlack_16_w400.copyWith(fontSize: 20, color: Colors.white),
        ),
      ),
      // CustomAppBar(),
      body: Body(item),
    );
  }
}

class ProductDetailsArguments {
  final ProductItemInfo product;

  ProductDetailsArguments({@required this.product});
}
