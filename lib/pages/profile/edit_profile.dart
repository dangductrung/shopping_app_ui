import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shopping_app/pages/profile/edit_profile_view_model.dart';
import 'package:shopping_app/pages/profile/profile_screen.dart';
import 'package:shopping_app/shared/base/base_view_state.dart';
import 'package:shopping_app/theme/ui_color.dart';
import 'package:shopping_app/theme/ui_text_style.dart';

class EditProfile extends StatefulWidget {
  @override
  EditProfileState createState() => EditProfileState();
}

class EditProfileState extends BaseViewState<EditProfile, EditProfileViewModel> {
  String email;
  String phone;
  String name;

  TextEditingController _email, _phone, _name;

  @override
  void initState() {
    super.initState();
    setState(() {
      email = "nghngtran68@gmail.com";
      phone = "0905854836";
      name = "Ngoc Tran Nguyen Hoang";
      _email = TextEditingController();
      _phone = TextEditingController();
      _name = TextEditingController();
    });
  }

  @override
  void dispose() {
    _email.dispose();
    _phone.dispose();
    _name.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height / 100;
    final width = MediaQuery.of(context).size.width / 100;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: Container(
          margin: EdgeInsets.symmetric(horizontal: width * 5),
          child: IconButton(
            icon: Icon(Icons.arrow_back_ios, color: Colors.white, size: 22),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        automaticallyImplyLeading: false,
        flexibleSpace: Container(
          padding: EdgeInsets.fromLTRB(0, 40, 0, 0),
          decoration: BoxDecoration(gradient: LinearGradient(begin: Alignment.topRight, end: Alignment.bottomLeft, colors: [UIColor.orange, UIColor.yellow])),
        ),
        title: Text(
          "Chỉnh sửa thông tin",
          style: UITextStyle.mediumBlack_16_w400.copyWith(fontSize: 20, color: Colors.white),
        ),
      ),
      // CustomAppBar(),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: height * 2),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              height: 50,
              margin: EdgeInsets.symmetric(vertical: 10),
              child: TextField(
                controller: _name,
                style: UITextStyle.mediumBlack_16_w400,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Họ tên",
                    labelText: "Nhập họ tên của bạn",
                    labelStyle: TextStyle(color: UIColor.black45),
                    focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black))),
                onChanged: (String value) {
                  name = value;
                },
              ),
            ),
            Container(
              height: 50,
              margin: EdgeInsets.symmetric(vertical: 10),
              child: TextField(
                obscureText: true,
                controller: _email,
                style: UITextStyle.mediumBlack_16_w400,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Email",
                    labelText: "Nhập email của bạn",
                    labelStyle: TextStyle(color: UIColor.black45),
                    focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black))),
                onSubmitted: (String value) {
                  email = value;
                },
              ),
            ),
            Container(
              height: 50,
              margin: EdgeInsets.symmetric(vertical: 10),
              child: TextField(
                obscureText: true,
                controller: _phone,
                style: UITextStyle.mediumBlack_16_w400,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Số điện thoại",
                    labelText: "Nhập số điện thoại",
                    labelStyle: TextStyle(color: UIColor.black45),
                    focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black))),
                onSubmitted: (String value) {
                  phone = value;
                },
              ),
            ),
            Container(
                height: 50,
                width: 400,
                margin: EdgeInsets.fromLTRB(0, 10, 0, 30),
                child: CupertinoButton(
                    color: UIColor.orangeBtn,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ProfileScreen()),
                      );
                    },
                    child: Text("Lưu", style: UITextStyle.white_16_w400.copyWith(fontSize: 18)))),
          ],
        ),
      ),
    );
  }

  @override
  EditProfileViewModel createViewModel() => EditProfileViewModel();
}
