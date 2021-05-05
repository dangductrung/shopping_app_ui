import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shopping_app/common/bottombar.dart';
import 'package:shopping_app/pages/signup/signup.dart';
import 'package:shopping_app/theme/ui_color.dart';
import 'package:shopping_app/theme/ui_text_style.dart';

class SignIn extends StatefulWidget {
  @override
  SignInState createState() => new SignInState();
}

class SignInState extends State<SignIn> {
  String username;
  String password;

  TextEditingController _username, _password;

  void initState() {
    super.initState();
    setState(() {
      username = "";
      password = "";
      _username = TextEditingController();
      _password = TextEditingController();
    });
  }

  void dispose() {
    _username.dispose();
    _password.dispose();
    super.dispose();
  }

  void signin() {}

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height/100;
    final width = MediaQuery.of(context).size.width/100;
    return Scaffold(
        body: Stack(
              children:<Widget>[
            Container(width: width*100, height: height*30,
            decoration: BoxDecoration(borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(280),
              bottomRight: Radius.circular(120)
            ), border: Border.all(
              color: Color(0xffFFAB73)
            ), color: Color(0xffFFAB73))),
            Center(
                child: SingleChildScrollView(
                    padding: EdgeInsets.symmetric(horizontal: 30),
                    child:
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(bottom: 20),
                              decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                      begin: Alignment.topRight,
                                      end: Alignment.bottomLeft,
                                      colors: [
                                        UIColor.orange,
                                        UIColor.yellow
                                      ]),
                                  borderRadius: BorderRadius.circular(15)),
                              width: width*25,
                              height: width*25,
                              child: Center(
                                  child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: <Widget>[
                                    Text("À HA",
                                        style: UITextStyle.white_16_w700.copyWith(
                                            color: Colors.white, fontSize: 28)),
                                    Text("SALE",
                                        style: UITextStyle.white_16_w700.copyWith(
                                            color: Colors.white, fontSize: 28)),
                                  ])),
                            ),
                            Container(
                              margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                              child: Text("Đăng nhập",
                                  style: UITextStyle.grayText_16_w700.copyWith(
                                      fontSize: 22, color: Colors.black54)),
                            ),
                            Container(
                              height: 50,
                              margin: EdgeInsets.symmetric(vertical: 10),
                              child: TextField(
                                controller: _username,
                                style: UITextStyle.mediumBlack_16_w400,
                                decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    hintText: "Tên đăng nhập",
                                    labelText: "Tên đăng nhập",
                                    labelStyle: TextStyle(color: Colors.black45),
                                    focusedBorder: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.black))),
                                onChanged: (String value) {
                                  username = value;
                                },
                              ),
                            ),
                            Container(
                              height: 50,
                              margin: EdgeInsets.symmetric(vertical: 10),
                              child: TextField(
                                obscureText: true,
                                controller: _password,
                                style: UITextStyle.mediumBlack_16_w400,
                                decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    hintText: "Mật khẩu",
                                    labelText: "Mật khẩu",
                                    labelStyle: TextStyle(color: Colors.black45),
                                    focusedBorder: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.black))),
                                onSubmitted: (String value) {
                                  password = value;
                                },
                              ),
                            ),
                            Container(
                                height: 50,
                                width: 400,
                                margin: EdgeInsets.fromLTRB(0, 10, 0, 30),
                                child: CupertinoButton(
                                    color: Color(0xffE45826),
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) => BottomBar()),
                                      );
                                    },
                                    child: Text("Đăng nhập",
                                        style: UITextStyle.white_16_w400
                                            .copyWith(fontSize: 18)))),
                            Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Text("Quên mật khẩu",
                                      style: UITextStyle.lightGreen_16_w700
                                          .copyWith(
                                              fontSize: 16,
                                              color: Color(0xffF0A500))),
                                ]),
                            Container(margin: EdgeInsets.fromLTRB(0, 10,0,0),
                              child: Row(children: <Widget>[
                                Text(
                                  "Bạn chưa có tài khoản? ",
                                  style: UITextStyle.grayText_16_w400.copyWith(
                                      color: Colors.black45, fontSize: 16),
                                ),
                                TextButton(onPressed: (){
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => SignUp()),
                                  );
                                },
                                  child: Text(
                                    "Đăng ký ngay",
                                    style: UITextStyle.grayText_16_w700.copyWith(
                                        color: Color(0xffF0A500), fontSize: 16),
                                  ),
                                )
                              ]),
                            ),
                          ]),
                    )),

        ]));
  }
}
