import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shopping_app/theme/ui_text_style.dart';

class NotificationInfo {
  String type;
  String msg;
  NotificationInfo(this.type, this.msg);
}

class NotifyItem extends StatelessWidget {
  NotificationInfo notificationInfo;
  NotifyItem(this.notificationInfo);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        decoration: BoxDecoration(color: Colors.white12),
        height: 80,
        child: Row(
          children: [
            Container(
              margin: EdgeInsets.only(left: 10),
              child: Image.asset("assets/icons/bell.png"),
              width: 25,
              height: 25,
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.fromLTRB(10, 15, 10, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "AhaSale thông báo",
                      style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 5),
                      child: Text(this.notificationInfo.msg, style: UITextStyle.mediumBlack_16_w400, maxLines: 4),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
