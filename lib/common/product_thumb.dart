import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shopping_app/theme/ui_text_style.dart';

class ProductThumb extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height / 100;
    final width = MediaQuery.of(context).size.width / 100;
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
      child: Stack(children: [
        Container(
          decoration: BoxDecoration(color: Colors.white, border: Border.all(color: Colors.white10, width: 2.0)),
          width: 180,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                margin: EdgeInsets.only(top: 10),
                child: Image.asset("assets/imgs/meow.jpg"),
                width: 120,
                height: 120,
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.fromLTRB(10, 5, 0, 0),
                  child: Column(
                    children: [
                      Text("Bình Hoa Thủy Tinh ", style: UITextStyle.mediumBlack_14_w700),
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 4),
                        child: Text("13.999.000", style: UITextStyle.red_16_w700),
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
            child: Text("-40%", style: TextStyle(fontWeight: FontWeight.w700))),
      ]),
    );
  }
}
