import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shopping_app/theme/ui_color.dart';
import 'package:shopping_app/theme/ui_text_style.dart';

import 'notification.dart';

class NotificationList extends StatefulWidget {
  @override
  NotificationListState createState() {
    return NotificationListState();
  }
}

class NotificationListState extends State<NotificationList> {
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
                    "Thông báo",
                    style: UITextStyle.mediumBlack_16_w400.copyWith(fontSize: 20, color: Colors.white),
                  )
                ],
              ),
            )),
        body: SafeArea(
            child: Container(
          height: height * 100,
          child: ListView.builder(
              itemCount: 15,
              itemBuilder: (context, index) {
                NotificationInfo item =
                    new NotificationInfo('discount', 'Sản phẩm Bình Hoa Thủy Tinh Trong Suốt Phong cách Bắc Âu hiện đang có giá thấp nhất');
                return NotifyItem(item);
              }),
        )));
  }
}
