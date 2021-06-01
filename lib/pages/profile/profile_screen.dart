import 'package:flutter/material.dart';
import 'package:shopping_app/pages/profile/profile_content.dart';
import 'package:shopping_app/theme/ui_color.dart';
import 'package:shopping_app/theme/ui_text_style.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: false,
          flexibleSpace: Container(
            padding: EdgeInsets.fromLTRB(0, 40, 0, 0),
            decoration: BoxDecoration(
                gradient: LinearGradient(begin: Alignment.topRight, end: Alignment.bottomLeft, colors: [UIColor.orange, UIColor.yellow])),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "Profile",
                  style: UITextStyle.mediumBlack_16_w400.copyWith(fontSize: 20, color: Colors.white),
                )
              ],
            ),
          )),
      body: Body(),
    );
  }
}
