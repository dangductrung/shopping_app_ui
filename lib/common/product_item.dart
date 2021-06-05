import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shopping_app/pages/details/details_screen.dart';
import 'package:shopping_app/theme/ui_text_style.dart';

enum source { Tiki, Lazada, Shopee }

class ProductItemInfo {
  final String name;
  final String curPrice;
  final String priceBefore;
  final String date;
  final String src;
  final String description;
  final String imgUrl;
  final bool isFavourite;
  ProductItemInfo(this.name, this.curPrice, this.priceBefore, this.date, this.src, this.description, this.imgUrl, this.isFavourite);
}

class ProductItem extends StatefulWidget {
  bool isFavourite;
  ProductItem(this.isFavourite);
  ProductItemState createState() => ProductItemState(isFavourite);
}

class ProductItemState extends State<ProductItem> {
  ProductItemInfo product;
  bool _isFavourite;
  ProductItemState(this._isFavourite);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => DetailsScreen(),
        ));
      },
      child: Container(
          height: 100,
          child: Row(
            children: [
              Container(
                margin: EdgeInsets.only(left: 10),
                child: Image.asset("assets/imgs/meow.jpg"),
                width: 80,
                height: 80,
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.fromLTRB(10, 15, 0, 0),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Bình Hoa Thủy Tinh Trong Suốt Phong Cách Bắc Âu",
                          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                          maxLines: 3,
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 10),
                          // ignore: prefer_const_literals_to_create_immutables
                          child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                            Text("Giá: ", style: UITextStyle.mediumBlack_14_w400),
                            // ignore: prefer_const_literals_to_create_immutables
                            Text("14.999.000", style: TextStyle(fontSize: 14, decoration: TextDecoration.lineThrough)),
                            Text("13.999.000", style: UITextStyle.red_16_w700),
                          ]),
                        ),
                        Expanded(
                          child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    // ignore: sized_box_for_whitespace
                                    Container(width: 20, height: 20, child: Image.asset("assets/icons/shopee.png")),
                                    Container(padding: EdgeInsets.symmetric(horizontal: 5), child: Text('Ngày cập nhật: 01/05/2021')),
                                  ],
                                ),
                              ],
                            ),
                            IconButton(
                                icon: Icon(
                                  Icons.favorite,
                                  color: _isFavourite ? Colors.red : Colors.grey,
                                ),
                                onPressed: () => setState(() => _isFavourite = !_isFavourite))
                          ]),
                        )
                      ]),
                ),
              ),
            ],
          )),
    );
  }
}
