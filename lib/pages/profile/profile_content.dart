import 'package:flutter/material.dart';
import 'package:shopping_app/pages/profile/profile_menu.dart';
import 'package:shopping_app/pages/profile/profile_pic.dart';

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
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Row(
              children: [
                Text(
                  'Điểm tích lũy ',
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
                ),
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
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15, color: Colors.green),
                ),
              ],
            ),
          ),
          ProfileMenu(
            text: "Log Out",
            icon: "assets/icons/Log out.svg",
            press: () {},
          ),
        ],
      ),
    );
  }
}
