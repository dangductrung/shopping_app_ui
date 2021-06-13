import 'package:flutter/material.dart';
import 'package:shopping_app/helpers/auth_helper.dart';
import 'package:shopping_app/injector.dart';
import 'package:shopping_app/pages/profile/profile_menu.dart';
import 'package:shopping_app/pages/profile/profile_pic.dart';
import 'package:shopping_app/pages/signin/signin.dart';
import 'package:shopping_app/theme/ui_text_style.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(vertical: 20),
      child: Column(
        children: [
          ProfilePic(),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Text(
              'Ngoc Tran Nguyen Hoang',
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Điểm tích lũy ',
                  style: UITextStyle.mediumBlack_16_w400,
                ),
                Row(
                  children: [
                    Image.asset(
                      'assets/imgs/dollar.png',
                      width: 20,
                      height: 20,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      '14',
                      style: UITextStyle.lightGreen_16_w600,
                    ),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Số điện thoại ',
                  style: UITextStyle.mediumBlack_16_w400,
                ),
                Text(
                  '0905854836',
                  style: UITextStyle.mediumBlack_16_w400,
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Email ',
                  style: UITextStyle.mediumBlack_16_w400,
                ),
                Text(
                  'nghngtran68@gmail.com',
                  style: UITextStyle.mediumBlack_16_w400,
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 20),
            child: ProfileMenu(
              text: "Đăng xuất",
              icon: "assets/icons/Log out.svg",
              press: () {
                injector<AuthHelper>().logout();
              },
            ),
          ),
        ],
      ),
    );
  }
}
