import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shopping_app/generated/assets.gen.dart';
import 'package:shopping_app/helpers/format_helpers.dart';
import 'package:shopping_app/models/notification_model.dart';
import 'package:shopping_app/theme/ui_color.dart';
import 'package:shopping_app/theme/ui_text_style.dart';
import 'package:shopping_app/extensions/size_ext.dart';

class NotifyItem extends StatelessWidget {
  final NotificationModel notification;

  const NotifyItem({this.notification});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10.0.h),
      decoration: BoxDecoration(
        color: !(notification?.is_read ?? false) ? UIColor.lightShadeGray : Colors.white,
      ),
      child: Row(
        children: [
          Container(
            margin: EdgeInsets.only(left: 10.0.w),
            width: 25.0.h,
            height: 25.0.h,
            child: notification.type == 'price_change' ? Assets.icons.icBell.image(height: 18.0.h, width: 18.0.h) : Assets.icons.announce.image(height: 18.0.h, width: 18.0.h),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10.0.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    notification?.title ?? "",
                    style: UITextStyle.mediumBlack_16_w700,
                  ),
                  SizedBox(
                    height: 5.0.h,
                  ),
                  Text(notification?.body ?? '', style: UITextStyle.mediumBlack_16_w400, maxLines: 4),
                  SizedBox(
                    height: 5.0.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(FormatHelper.formatDateTime(notification?.created_at, pattern: "dd/MM/yyyy HH:mm"), style: UITextStyle.mediumBlack_14_w400, maxLines: 4),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
