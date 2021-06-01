import 'package:flutter/material.dart';
import 'package:shopping_app/common/product_item.dart';
import 'package:shopping_app/pages/details/components/product_images.dart';
import 'package:shopping_app/pages/details/label_checkbox.dart';
import 'package:shopping_app/theme/ui_color.dart';

import 'product_description.dart';
import 'top_rounded_container.dart';

class Body extends StatelessWidget {
  final ProductItemInfo product;

  const Body(this.product);

  void showDialog(BuildContext context) {
    showGeneralDialog(
      barrierLabel: "Barrier",
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: Duration(milliseconds: 700),
      context: context,
      pageBuilder: (_, __, ___) {
        return Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 20),
            height: 360,
            margin: EdgeInsets.only(bottom: 20, left: 12, right: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              children: [
                Text(
                  'Vui lòng chọn lý do báo lỗi',
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15, color: Colors.black),
                ),
                SizedBox(
                  height: 10,
                ),
                LabelCheckboxWidget('Sản phẩm không tồn tại'),
                LabelCheckboxWidget('Sản phẩm không đúng giá'),
                LabelCheckboxWidget('Sai sản phẩm mong đợi'),
                LabelCheckboxWidget('Lý do khác'),
                LabelCheckboxWidget('Sản phẩm không tồn tại'),
                Container(
                  margin: EdgeInsets.only(top: 10),
                  width: 80,
                  height: 40,
                  decoration: BoxDecoration(
                    color: UIColor.yellow,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: GestureDetector(
                    child: Center(
                      child: Text(
                        'Gửi',
                        style: TextStyle(fontWeight: FontWeight.w500, fontSize: 17, color: Colors.white),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
      transitionBuilder: (_, anim, __, child) {
        return SlideTransition(
          position: Tween(begin: Offset(0, 1), end: Offset(0, 0)).animate(anim),
          child: child,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width / 375;
    return ListView(
      children: [
        ProductImages(product: product),
        TopRoundedContainer(
          color: Colors.white,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              ProductDescription(
                product: product,
                pressOnComplain: () {
                  showDialog(context);
                },
              ),
              Container(
                color: Colors.white,
                padding: EdgeInsets.only(
                  left: w * 375 * 0.15,
                  right: w * 375 * 0.15,
                  bottom: w * (5),
                  top: w * (5),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 10),
                      height: w * 45,
                      width: w * 375 * 0.8,
                      child: FlatButton(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        color: UIColor.yellow,
                        child: Text("Đến trang bán hàng",
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                            )),
                        onPressed: () {},
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
