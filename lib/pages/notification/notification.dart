import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shopping_app/generated/assets.gen.dart';
import 'package:shopping_app/theme/ui_text_style.dart';

class NotificationInfo {
  String type;
  String msg;
  bool isRead;
  NotificationInfo(this.type, this.msg, this.isRead);
}

class NotifyItem extends StatelessWidget {
  NotificationInfo notificationInfo;
  NotifyItem(this.notificationInfo);
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height / 100;
    final width = MediaQuery.of(context).size.width / 100;
    return GestureDetector(
      onTap: () {},
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10),
        // height: width * 23,
        decoration: BoxDecoration(
          color: this.notificationInfo.isRead ? Colors.white10.withOpacity(0.1) : Colors.white,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.only(left: 10),
              child: this.notificationInfo.type == 'discount'
                  ? Assets.icons.icBell.image(height: 18.0, width: 18.0)
                  : Assets.icons.announce.image(height: 18.0, width: 18.0),
              width: 25,
              height: 25,
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
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
