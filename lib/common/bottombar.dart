import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shopping_app/pages/favoriteList/favoriteList.dart';
import 'package:shopping_app/pages/home/home.dart';
import 'package:shopping_app/pages/notification/notificationList.dart';
import 'package:shopping_app/pages/profile/profile_screen.dart';
import 'package:shopping_app/theme/ui_text_style.dart';
// final GlobalKey<NavigatorState> firstTabNavKey = GlobalKey<NavigatorState>();
// final GlobalKey<NavigatorState> secondTabNavKey = GlobalKey<NavigatorState>();
// final GlobalKey<NavigatorState> thirdTabNavKey = GlobalKey<NavigatorState>();

class BottomBar extends StatefulWidget {
  BottomBarState createState() => BottomBarState();
}

class BottomBarState extends State<BottomBar> {
  List<Widget> _pages = [
    HomeScreen(), // see the FrontPage class
    NotificationList(),
    FavoriteList(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CupertinoPageScaffold(
        child: CupertinoTabScaffold(
            tabBar: CupertinoTabBar(
              activeColor: Color(0xffF12711),
              items: [
                BottomNavigationBarItem(
                    icon: Icon(Icons.home_outlined),
                    title: Text(
                      "Trang chủ",
                      style: UITextStyle.mediumBlack_12_w400,
                    )),
                BottomNavigationBarItem(
                    icon: Icon(Icons.search_outlined),
                    title: Text(
                      "Thông báo",
                      style: UITextStyle.mediumBlack_12_w400,
                    )),
                BottomNavigationBarItem(
                    icon: Icon(Icons.favorite_border),
                    title: Text(
                      "Yêu thích",
                      style: UITextStyle.mediumBlack_12_w400,
                    )),
                BottomNavigationBarItem(
                    icon: Icon(Icons.account_circle_outlined),
                    title: Text(
                      "Tài khoản",
                      style: UITextStyle.mediumBlack_12_w400,
                    )),
              ],
            ),
            tabBuilder: (BuildContext context, index) {
              return _pages[index];
            }),
      ),
    );
  }
}

// class FrontPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Text('Front Page'),
//     );
//   }
// }
//
// // Settings Page
// class SettingsPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Text('Settings'),
//     );
//   }
// }
