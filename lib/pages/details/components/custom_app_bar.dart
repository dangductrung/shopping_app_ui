import 'package:flutter/material.dart';

class CustomAppBar extends PreferredSize {
  @override
  // AppBar().preferredSize.height provide us the height that appy on our app bar
  Size get preferredSize => Size.fromHeight(AppBar().preferredSize.height);

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width / 375;
    return SafeArea(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: w * (20)),
        child: Row(
          children: [
            SizedBox(
              height: w * (40),
              width: w * (40),
              child: FlatButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(60),
                  ),
                  color: Colors.white,
                  padding: EdgeInsets.zero,
                  onPressed: () => Navigator.pop(context),
                  child: Icon(Icons.arrow_back_ios_outlined)),
            ),
          ],
        ),
      ),
    );
  }
}
