import 'package:flutter/material.dart';
import 'package:shopping_app/common/product_item.dart';
import 'package:shopping_app/pages/details/chart/line_chart.dart';
import 'package:shopping_app/theme/ui_text_style.dart';

class ProductDescription extends StatelessWidget {
  const ProductDescription({
    Key key,
    @required this.product,
    this.pressOnComplain,
  }) : super(key: key);

  final ProductItemInfo product;
  final GestureTapCallback pressOnComplain;

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width / 375;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          // width: w * 100,
          height: 100,
          padding: EdgeInsets.fromLTRB(w * 20, w * 20, w * 20, w * 20),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  product.name,
                  maxLines: 3,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              // TextSpan(

              Container(
                margin: EdgeInsets.only(bottom: w * 2, right: w * 2),
                width: 30,
                height: 30,
                child: IconButton(
                    icon: Icon(
                      Icons.favorite,
                      color: product.isFavourite ? Colors.red : Colors.white,
                      size: 30,
                    ),
                    onPressed: () {}),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: w * 20, vertical: w * 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Giá hiện tại', style: UITextStyle.gray_16_w400.copyWith(fontSize: 16, fontWeight: FontWeight.w500)),
              Text(
                product.curPrice,
                style: UITextStyle.lightGreen_16_w700.copyWith(fontSize: 18),
              )
            ],
          ),
        ),

        Padding(
          padding: EdgeInsets.symmetric(horizontal: w * 20, vertical: w * 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Giá thấp nhất', style: UITextStyle.gray_16_w400.copyWith(fontSize: 16, fontWeight: FontWeight.w500)),
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
              Text('Giá cao nhất', style: UITextStyle.gray_16_w400.copyWith(fontSize: 16, fontWeight: FontWeight.w500)),
              Text(
                product.curPrice,
                style: UITextStyle.mediumBlack_16_w400,
              )
            ],
          ),
        ),

        Padding(
          padding: EdgeInsets.fromLTRB(w * 20, w * 20, w * 20, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Thông tin sản phẩm chưa chính xác?",
                style: TextStyle(fontWeight: FontWeight.w400, color: Colors.black45, fontSize: 14),
              ),
              GestureDetector(
                onTap: () {},
                child: Row(
                  children: [
                    Text(
                      'Vui lòng báo lỗi cho chúng tôi',
                      style: TextStyle(fontWeight: FontWeight.w400, color: Colors.black45, fontSize: 14),
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
        // ),
        Padding(padding: EdgeInsets.symmetric(horizontal: w * 20, vertical: w * 20), child: LineChartSample1())
      ],
    );
  }
}
