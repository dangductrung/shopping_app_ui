import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shopping_app/theme/ui_color.dart';
import 'package:shopping_app/theme/ui_text_style.dart';

class ProductItem extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Container(height: 100,
      child: Row(
        children: [
          Container(margin: EdgeInsets.only(left: 10),
           child:Image.asset("assets/imgs/meow.jpg"),width: 80, height: 80,),
          Expanded(
            child: Container(padding: EdgeInsets.fromLTRB(10, 15, 0, 0),
              child: Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Bình Hoa Thủy Tinh Trong Suốt Phong Cách Bắc Âu", style: UITextStyle.mediumBlack_14_w700),
                  Container(margin: EdgeInsets.symmetric(vertical: 4),
                    child: Row(mainAxisSize: MainAxisSize.max, mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                      Text("Giá: ",style: UITextStyle.mediumBlack_14_w400),
                      Text("14.999.000", style: TextStyle(fontSize: 14, decoration: TextDecoration.lineThrough)),
                      Text("13.999.000", style: UITextStyle.red_16_w700),
                ]),
                  ),
              Expanded(
                child: Row(mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        width: 20, height: 20,
                        child: Image.asset("assets/icons/shopee.png")),
                        Container(padding: EdgeInsets.symmetric(horizontal: 5),
                            child: Text('Ngày cập nhật: 01/05/2021')),
                      ]),
              )]
              ),
            ),
          ),
        ],
      )
    );
  }
}