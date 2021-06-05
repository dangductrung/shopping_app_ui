import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shopping_app/pages/details/details_screen.dart';
import 'package:shopping_app/theme/ui_color.dart';
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
    final name = item.name.length > 40 ? item.name.substring(0, 40) + '...' : item.name;
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => DetailsScreen(),
        ));
      },
      child: Container(
        width: width * 45,
        height: width * 48,
        margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
        child: Stack(children: [
          Container(
            decoration: BoxDecoration(color: UIColor.lightGray, border: Border.all(color: UIColor.black12, width: 2.0)),
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
                  width: height * 15,
                  height: height * 12,
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
