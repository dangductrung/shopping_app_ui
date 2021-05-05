import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shopping_app/common/searchbar.dart';
import 'package:shopping_app/pages/home/home.dart';
import 'package:shopping_app/pages/search/search.dart';
import 'package:shopping_app/theme/ui_color.dart';
import 'package:shopping_app/theme/ui_text_style.dart';
import '../main.dart';
// final GlobalKey<NavigatorState> firstTabNavKey = GlobalKey<NavigatorState>();
// final GlobalKey<NavigatorState> secondTabNavKey = GlobalKey<NavigatorState>();
// final GlobalKey<NavigatorState> thirdTabNavKey = GlobalKey<NavigatorState>();

class BottomBar extends StatefulWidget{
  BottomBarState createState() => BottomBarState();
}
class BottomBarState extends State<BottomBar>{
  List<Widget> _pages = [
    HomeScreen(), // see the FrontPage class
    SearchTab(),
    SearchTab(),/// see the SettingsPage class
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CupertinoPageScaffold(
        child: CupertinoTabScaffold(
            tabBar: CupertinoTabBar(
              activeColor: Color(0xffF12711),
              items: [
                BottomNavigationBarItem(icon: Icon(Icons.home), title: Text("Home", style: UITextStyle.mediumBlack_12_w400,)),
                BottomNavigationBarItem(icon: Icon(Icons.search),title: Text("Search", style: UITextStyle.mediumBlack_12_w400,)),
                BottomNavigationBarItem(icon: Icon(Icons.account_circle_rounded), title: Text("Profile", style: UITextStyle.mediumBlack_12_w400,))
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