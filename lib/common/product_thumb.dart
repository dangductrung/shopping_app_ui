import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shopping_app/pages/details/details_screen.dart';
import 'package:shopping_app/theme/ui_text_style.dart';

class ProductThumbInfo {
  final String name;
  final String price;
  final String discountPercent;
  final String imgUrl;
  ProductThumbInfo(this.name, this.price, this.discountPercent, this.imgUrl);
}

class ProductThumb extends StatelessWidget {
  final ProductThumbInfo item;
  ProductThumb(this.item);
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height / 100;
    final width = MediaQuery.of(context).size.width / 100;
    final name = item.name.length > 35 ? item.name.substring(0, 30) + '...' : item.name;
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => DetailsScreen(),
        ));
      },
      child: Container(
        width: width * 42,
        height: height * 30,
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        child: Stack(children: [
          Container(
            decoration: BoxDecoration(color: Colors.white12, border: Border.all(color: Colors.black12, width: 2.0)),
            width: 180,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  margin: EdgeInsets.only(top: 10),
                  child: Image.asset(
                    item.imgUrl,
                    fit: BoxFit.contain,
                  ),
                  width: 100,
                  height: 110,
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.fromLTRB(10, 5, 0, 0),
                    child: Column(
                      children: [
                        Text(name, style: UITextStyle.mediumBlack_14_w400),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              margin: EdgeInsets.symmetric(vertical: 4, horizontal: 4),
                              child: Text(item.price, style: UITextStyle.red_16_w700),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
              alignment: Alignment.center,
              color: Colors.yellow,
              width: width * 10,
              height: height * 5,
              child: Text("-" + item.discountPercent, style: TextStyle(fontWeight: FontWeight.w700))),
        ]),
      ),
    );
  }
}
