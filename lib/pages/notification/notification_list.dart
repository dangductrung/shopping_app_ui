import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopping_app/pages/notification/notification_view_model.dart';
import 'package:shopping_app/pages/notification/notification_widget.dart';
import 'package:shopping_app/shared/base/base_view_state.dart';
import 'package:shopping_app/shared/view/easy_list_view.dart';
import 'package:shopping_app/theme/ui_color.dart';
import 'package:shopping_app/theme/ui_text_style.dart';
import 'package:shopping_app/extensions/size_ext.dart';

class NotificationList extends StatefulWidget {
  @override
  NotificationListState createState() {
    return NotificationListState();
  }
}

class NotificationListState extends BaseViewState<NotificationList, NotificationViewModel> {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      backgroundColor: UIColor.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        flexibleSpace: Container(
          padding: EdgeInsets.fromLTRB(5.0.w, 14.0.h, 0, 0),
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [Color(0xffF12711), Color(0xffF5AF19)],
            ),
          ),
        ),
        actions: [
          GestureDetector(
            onTap: viewModel.onReadAll,
            child: Padding(
              padding: EdgeInsets.only(right: 16.0.w),
              child: Center(
                child: Icon(
                  Icons.check,
                  size: 24.0.h,
                ),
              ),
            ),
          )
        ],
        title: Text(
          "Thông báo",
          style: UITextStyle.white_18_w400,
        ),
      ),
      body: Obx(
        () => RefreshIndicator(
          onRefresh: () async {
            viewModel.page = 0;
            viewModel.getData();
            return true;
          },
          child: EasyListView(
              onLoadMore: () {
                viewModel.getData();
              },
              loadMore: viewModel.isHaveLoadMore,
              itemCount: viewModel.notifications?.length ?? 0,
              itemBuilder: (context, index) {
                return GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: () => viewModel.onReadNotification(index),
                  child: NotifyItem(
                    notification: viewModel.notifications[index],
                  ),
                );
              }),
        ),
      ),
    );
  }

  @override
  NotificationViewModel createViewModel() => NotificationViewModel();
}
