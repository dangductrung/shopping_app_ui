import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shopping_app/common/bottombar.dart';
import 'package:shopping_app/common/form_error.dart';
import 'package:shopping_app/constants/constants.dart';
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
  final _signinKey = GlobalKey<FormState>();
  final List<String> errors = [];
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

  void addError({String error}) {
    if (!errors.contains(error))
      setState(() {
        errors.add(error);
      });
  }

  void removeError({String error}) {
    if (errors.contains(error))
      setState(() {
        errors.remove(error);
      });
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height / 100;
    final width = MediaQuery.of(context).size.width / 100;
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(children: <Widget>[
          Container(
              width: width * 100,
              height: height * 30,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(280), bottomRight: Radius.circular(120)),
                  border: Border.all(color: UIColor.lightOrange),
                  color: UIColor.lightOrange)),
          Center(
              child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 30),
            child: Form(
              key: _signinKey,
              child: Column(crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
                Container(
                  margin: EdgeInsets.only(bottom: 20),
                  decoration: BoxDecoration(
                      gradient: LinearGradient(begin: Alignment.topRight, end: Alignment.bottomLeft, colors: [UIColor.orange, UIColor.yellow]),
                      borderRadius: BorderRadius.circular(15)),
                  width: width * 25,
                  height: width * 25,
                  child: Center(
                      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
                    Text("À HA", style: UITextStyle.mediumWhite_22_w700),
                    Text("SALE", style: UITextStyle.mediumWhite_22_w700),
                  ])),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10),
                  child: TextFormField(
                    validator: (value) {
                      if (value.isEmpty) {
                        addError(error: usernameNullError);
                        return "";
                      }
                      return null;
                    },
                    controller: _username,
                    style: UITextStyle.mediumBlack_16_w400,
                    decoration: const InputDecoration(
                        contentPadding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
                        border: OutlineInputBorder(),
                        hintText: "Tên đăng nhập",
                        labelText: "Tên đăng nhập",
                        labelStyle: TextStyle(color: UIColor.black45),
                        focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black))),
                    onChanged: (String value) {
                      if (value.isNotEmpty) {
                        removeError(error: usernameNullError);
                      }
                      username = value;
                    },
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10),
                  child: TextFormField(
                    validator: (value) {
                      if (value.isEmpty) {
                        addError(error: kPassNullError);
                        return "";
                      }
                      if (value.length < 8) {
                        addError(error: kShortPassError);
                        return "";
                      }
                      return null;
                    },
                    obscureText: true,
                    controller: _password,
                    style: UITextStyle.mediumBlack_16_w400,
                    decoration: const InputDecoration(
                        contentPadding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
                        border: OutlineInputBorder(),
                        hintText: "Mật khẩu",
                        labelText: "Mật khẩu",
                        labelStyle: TextStyle(color: UIColor.black45),
                        focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black))),
                    onChanged: (String value) {
                      if (value.isNotEmpty) {
                        removeError(error: kPassNullError);
                      } else if (value.length >= 8) {
                        removeError(error: kShortPassError);
                      }
                      password = value;
                    },
                  ),
                ),
                FormError(errors: errors),
                Container(
                    height: 50,
                    width: 400,
                    margin: EdgeInsets.fromLTRB(0, 10, 0, 30),
                    child: CupertinoButton(
                        color: UIColor.orangeBtn,
                        onPressed: () {
                          if (_signinKey.currentState.validate()) {
                            _signinKey.currentState.save();

                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => BottomBar()),
                            );
                          }
                        },
                        child: Text("Đăng nhập", style: UITextStyle.white_16_w400.copyWith(fontSize: 18)))),
                Row(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
                  Text("Quên mật khẩu", style: UITextStyle.darkYellow_16_w600),
                ]),
                Container(
                  child: Row(children: <Widget>[
                    Text(
                      "Bạn chưa có tài khoản? ",
                      style: UITextStyle.grayText_16_w400.copyWith(color: Colors.black45, fontSize: 16),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => SignUp()),
                        );
                      },
                      child: Text(
                        "Đăng ký ngay",
                        style: UITextStyle.darkYellow_16_w600,
                      ),
                    )
                  ]),
                ),
              ]),
            ),
          )),
        ]));
  }
}
