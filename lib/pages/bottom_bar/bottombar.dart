import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:keyboard_service/keyboard_service.dart';
import 'package:shopping_app/pages/bottom_bar/bottom_bar_view_model.dart';
import 'package:shopping_app/shared/base/base_view_state.dart';
import 'package:shopping_app/theme/ui_color.dart';
import 'package:shopping_app/theme/ui_text_style.dart';
import 'package:shopping_app/extensions/size_ext.dart';

class BottomBar extends StatefulWidget {
  @override
  BottomBarState createState() => BottomBarState();
}

class BottomBarState extends BaseViewState<BottomBar, BottomBarViewModel> {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return KeyboardAutoDismiss(
      scaffold: Scaffold(
        bottomNavigationBar: Obx(
          () => BottomNavigationBar(
            currentIndex: viewModel.index,
            items: [
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.home_outlined,
                  color: UIColor.mediumLightShadeGray,
                  size: 24.0.h,
                ),
                activeIcon: Icon(
                  Icons.home_outlined,
                  color: UIColor.orange,
                  size: 24.0.h,
                ),
                title: Text(
                  "Trang chủ",
                  style: UITextStyle.mediumBlack_14_w400,
                ),
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.whatshot_outlined,
                  color: UIColor.mediumLightShadeGray,
                  size: 24.0.h,
                ),
                title: Text(
                  "Thông báo",
                  style: UITextStyle.mediumBlack_14_w400,
                ),
                activeIcon: Icon(
                  Icons.whatshot_outlined,
                  color: UIColor.orange,
                  size: 24.0.h,
                ),
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.favorite_border,
                  color: UIColor.mediumLightShadeGray,
                  size: 24.0.h,
                ),
                activeIcon: Icon(
                  Icons.favorite_border,
                  color: UIColor.orange,
                  size: 24.0.h,
                ),
                title: Text(
                  "Yêu thích",
                  style: UITextStyle.mediumBlack_14_w400,
                ),
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.account_circle_outlined,
                  color: UIColor.mediumLightShadeGray,
                  size: 24.0.h,
                ),
                activeIcon: Icon(
                  Icons.account_circle_outlined,
                  color: UIColor.orange,
                  size: 24.0.h,
                ),
                title: Text(
                  "Tài khoản",
                  style: UITextStyle.mediumBlack_14_w400,
                ),
              ),
            ],
            onTap: viewModel.onBarTapped,
          ),
        ),
        body: PageView(
          controller: viewModel.pageController,
          onPageChanged: viewModel.onBarTapped,
          children: viewModel.pages,
        ),
      ),
    );
  }

  @override
  BottomBarViewModel createViewModel() => BottomBarViewModel();
}
