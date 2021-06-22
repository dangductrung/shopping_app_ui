import 'package:flutter/material.dart';
import 'package:shopping_app/common/product_item.dart';
import 'package:shopping_app/pages/details/chart/line_chart.dart';
import 'package:shopping_app/theme/ui_text_style.dart';

import 'body.dart';

class ProductDescription extends StatelessWidget {
  const ProductDescription({
    Key key,
    @required this.product,
    this.pressOnComplain,
    this.pressFavorite,
  }) : super(key: key);

  final ProductItemInfo product;
  final GestureTapCallback pressOnComplain;
  final GestureTapCallback pressFavorite;
  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width / 375;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 100,
          padding: EdgeInsets.fromLTRB(w * 20, w * 20, w * 20, w * 20),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  product.name,
                  maxLines: 4,
                  style: UITextStyle.black_18_w500,
                ),
              ),
              // TextSpan(
              Container(
                margin: EdgeInsets.only(
                  right: w * 2,
                ),
                width: 25,
                height: 25,
                child: GestureDetector(
                    child: Icon(
                      Icons.favorite,
                      color: product.isFavourite ? Colors.red : Colors.white,
                      size: 30,
                    ),
                    onTap: pressFavorite),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: w * 20, vertical: w * 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Giá hiện tại', style: UITextStyle.grayText_16_w500),
              Text(
                product.curPrice,
                style: UITextStyle.blue_18_w600,
              )
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: w * 20, vertical: w * 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Giá thấp nhất', style: UITextStyle.grayText_16_w500),
              Text(
                product.curPrice,
                style: UITextStyle.mediumBlack_16_w400,
              )
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: w * 20, vertical: w * 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Giá cao nhất', style: UITextStyle.grayText_16_w500),
              Text(
                product.curPrice,
                style: UITextStyle.mediumBlack_16_w400,
              )
            ],
          ),
        ),
        Padding(padding: EdgeInsets.symmetric(horizontal: w * 20, vertical: w * 20), child: LineChartSample1()),
        Padding(
          padding: EdgeInsets.fromLTRB(w * 20, w * 20, w * 20, w * 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Thông tin sản phẩm chưa chính xác?",
                style: UITextStyle.black45_14_w400,
              ),
              GestureDetector(
                onTap: () {},
                child: Row(
                  children: [
                    Text(
                      'Vui lòng báo lỗi cho chúng tôi',
                      style: UITextStyle.black45_14_w400,
                    ),
                    SizedBox(width: 5),
                    GestureDetector(
                      onTap: pressOnComplain,
                      child: Text(
                        "Báo lỗi ngay ",
                        style: TextStyle(fontWeight: FontWeight.w500, color: Colors.blue, fontSize: 14),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
