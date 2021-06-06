import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shopping_app/pages/signin/sign_in_view_model.dart';
import 'package:shopping_app/pages/signup/signup.dart';
import 'package:shopping_app/shared/base/base_view_state.dart';
import 'package:shopping_app/theme/ui_color.dart';
import 'package:shopping_app/theme/ui_text_style.dart';

class SignIn extends StatefulWidget {
  @override
  SignInState createState() => SignInState();
}

class SignInState extends BaseViewState<SignIn, SignInViewModel> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height / 100;
    final width = MediaQuery.of(context).size.width / 100;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: <Widget>[
          Container(
              width: width * 100,
              height: height * 30,
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(280), bottomRight: Radius.circular(120)),
                  border: Border.all(color: UIColor.lightOrange),
                  color: UIColor.lightOrange)),
          Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Form(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      margin: const EdgeInsets.only(bottom: 20),
                      decoration: BoxDecoration(
                          gradient: const LinearGradient(begin: Alignment.topRight, end: Alignment.bottomLeft, colors: [UIColor.orange, UIColor.yellow]), borderRadius: BorderRadius.circular(15)),
                      width: width * 25,
                      height: width * 25,
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Text("À HA", style: UITextStyle.mediumWhite_22_w700),
                            Text("SALE", style: UITextStyle.mediumWhite_22_w700),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      child: TextFormField(
                        controller: TextEditingController(),
                        style: UITextStyle.mediumBlack_16_w400,
                        decoration: const InputDecoration(
                            contentPadding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
                            border: OutlineInputBorder(),
                            hintText: "Tên đăng nhập",
                            labelText: "Tên đăng nhập",
                            labelStyle: TextStyle(color: UIColor.black45),
                            focusedBorder: OutlineInputBorder()),
                        onChanged: viewModel.onUsernameChanged,
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      child: TextFormField(
                        obscureText: true,
                        controller: TextEditingController(),
                        style: UITextStyle.mediumBlack_16_w400,
                        decoration: const InputDecoration(
                            contentPadding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
                            border: OutlineInputBorder(),
                            hintText: "Mật khẩu",
                            labelText: "Mật khẩu",
                            labelStyle: TextStyle(color: UIColor.black45),
                            focusedBorder: OutlineInputBorder()),
                        onChanged: viewModel.onPassChanged,
                      ),
                    ),
                    Container(
                        height: 50,
                        width: 400,
                        margin: const EdgeInsets.fromLTRB(0, 10, 0, 30),
                        child: CupertinoButton(color: UIColor.orangeBtn, onPressed: viewModel.onBtnClicked, child: Text("Đăng nhập", style: UITextStyle.white_16_w400.copyWith(fontSize: 18)))),
                    Row(
                      children: const [
                        Text("Quên mật khẩu", style: UITextStyle.darkYellow_16_w600),
                      ],
                    ),
                    Row(
                      children: <Widget>[
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
                          child: const Text(
                            "Đăng ký ngay",
                            style: UITextStyle.darkYellow_16_w600,
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  SignInViewModel createViewModel() => SignInViewModel();
}
