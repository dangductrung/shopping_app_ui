import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shopping_app/pages/signin/signin.dart';
import 'package:shopping_app/theme/ui_text_style.dart';

class SignUp extends StatefulWidget {
  @override
  SignUpState createState() => new SignUpState();
}

class SignUpState extends State<SignUp> {
  String username;
  String password;
  String confirmPassword;
  TextEditingController _username, _password, _confirmPassword;

  void initState() {
    super.initState();
    setState(() {
      username = "";
      password = "";
      _username = TextEditingController();
      _password = TextEditingController();
      _confirmPassword = TextEditingController();
    });
  }

  void dispose() {
    _username.dispose();
    _password.dispose();
    _confirmPassword.dispose();
    super.dispose();
  }
  void signup(){

  }
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height/100;
    final width = MediaQuery.of(context).size.width/100;
    return Scaffold(
        body: Stack(
            children:<Widget>[
        Container(width: width*106, height: height*25,
            decoration: BoxDecoration(borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(280),
                bottomRight: Radius.circular(120)
            ), border: Border.all(
                color: Color(0xffFFAB73)
            ), color: Color(0xffFFAB73))),(
            Center(
                child: SingleChildScrollView(
                    padding: EdgeInsets.symmetric(horizontal: 30),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(margin: EdgeInsets.only(bottom: 20, top: 25),
                            decoration: BoxDecoration(gradient: LinearGradient(
                            begin: Alignment.topRight,
                            end:Alignment.bottomLeft,
                            colors: [
                              Color(0xffF12711),
                              Color(0xffF5AF19)
                            ]
                          ), borderRadius: BorderRadius.circular(15)
                          ),width: 120,height: 120, child: Center(child:
                          Column(mainAxisAlignment: MainAxisAlignment.center,
                              children:<Widget>[
                            Text("À HA", style: UITextStyle.white_16_w700.copyWith(color: Colors.white, fontSize: 28)),
                            Text("SALE", style: UITextStyle.white_16_w700.copyWith(color: Colors.white, fontSize: 28)),
                          ])),),
                          Container(
                            margin: EdgeInsets.fromLTRB(0, 10, 0, 30),
                            child: Text(
                                "Đăng ký ngay để nhận thêm nhiều ưu đãi",
                                style: UITextStyle.grayText_16_w700.copyWith(
                                    fontSize: 17, color: Colors.black54)),
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
                                      borderSide: BorderSide(color: Colors.black)
                                  )),
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
                                      borderSide: BorderSide(color: Colors.black)
                                  )),
                              onSubmitted: (String value) {
                                password = value;
                              },
                            ),
                          ),
                          Container(
                            height: 50,
                            margin: EdgeInsets.symmetric(vertical: 10),
                            child: TextField(
                              obscureText: true,
                              controller: _confirmPassword,
                              style: UITextStyle.mediumBlack_16_w400,
                              decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  hintText: "Nhập lại mật khẩu",
                                  labelText: "Xác nhận mật khẩu",
                                  labelStyle: TextStyle(color: Colors.black45),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: Colors.black)
                                  )),
                              onSubmitted: (String value) {
                                password = value;
                              },
                            ),
                          ),
                          Container(
                              height: 50,
                              width: 400,
                              margin: EdgeInsets.symmetric(vertical: 30),
                              child: CupertinoButton(
                                  color: Color(0xffE45826),
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => SignIn()),
                                    );
                                  },
                                  child: Text("Đăng ký",
                                      style: UITextStyle.white_16_w400.copyWith(fontSize: 18)))),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.baseline,
                              children: <Widget>[
                                Text("Bạn đã có tài khoản? ",
                                    style: UITextStyle.grayText_16_w400),
                                TextButton(onPressed: (){
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => SignIn()),
                                  );
                                },
                                  child: Text("Đăng nhập ",
                                      style: UITextStyle.lightGreen_16_w700
                                          .copyWith(
                                              fontSize: 16, color: Color(0xffF0A500))),
                                ),
                              ]),
                        ])))
              )]));
  }
}
