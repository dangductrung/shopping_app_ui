import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:keyboard_service/keyboard_service.dart';
import 'package:shopping_app/generated/assets.gen.dart';
import 'package:shopping_app/pages/signup/sign_up_view_model.dart';
import 'package:shopping_app/shared/base/base_view_state.dart';
import 'package:shopping_app/theme/ui_color.dart';
import 'package:shopping_app/theme/ui_text_style.dart';

class SignUp extends StatefulWidget {
  @override
  SignUpState createState() => SignUpState();
}

class SignUpState extends BaseViewState<SignUp, SignUpViewModel> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height / 100;

    return KeyboardAutoDismiss(
      scaffold: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: height * 15),
          child: Form(
            child: Column(
              children: <Widget>[
                Assets.icons.icLogo.image(height: 120, width: 120),
                const SizedBox(
                  height: 16.0,
                ),
                Container(
                  margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                  child: Text("Đăng ký ngay để nhận thêm nhiều ưu đãi", style: UITextStyle.black54_16_w400),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: height * 1),
                  child: TextFormField(
                      autocorrect: false,
                      style: UITextStyle.mediumBlack_16_w400,
                      decoration: const InputDecoration(
                          contentPadding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
                          border: OutlineInputBorder(),
                          hintText: "Tên đăng nhập",
                          labelText: "Tên đăng nhập",
                          labelStyle: TextStyle(color: Colors.black45),
                          focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black))),
                      onChanged: viewModel.onUsernameChanged),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: height * 1),
                  child: TextFormField(
                    autocorrect: false,
                    obscureText: true,
                    style: UITextStyle.mediumBlack_16_w400,
                    decoration: const InputDecoration(
                        contentPadding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
                        border: OutlineInputBorder(),
                        hintText: "Mật khẩu",
                        labelText: "Mật khẩu",
                        labelStyle: TextStyle(color: Colors.black45),
                        focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black))),
                    onChanged: viewModel.onPwdChanged,
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: height * 1),
                  child: TextFormField(
                      autocorrect: false,
                      obscureText: true,
                      style: UITextStyle.mediumBlack_16_w400,
                      decoration: const InputDecoration(
                          contentPadding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
                          border: OutlineInputBorder(),
                          hintText: "Nhập lại mật khẩu",
                          labelText: "Xác nhận mật khẩu",
                          labelStyle: TextStyle(color: UIColor.black45),
                          focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black))),
                      onChanged: viewModel.onConfirmPwdChanged),
                ),
                Container(
                  height: 50,
                  width: 400,
                  margin: EdgeInsets.symmetric(vertical: height * 2),
                  child: CupertinoButton(
                    color: UIColor.orangeBtn,
                    onPressed: viewModel.onRegisterClicked,
                    child: Text("Đăng ký", style: UITextStyle.white_18_w400),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  children: <Widget>[
                    Text("Bạn đã có tài khoản? ", style: UITextStyle.grayText_16_w400),
                    TextButton(
                      onPressed: viewModel.onSignInClicked,
                      child: Text("Đăng nhập ", style: UITextStyle.darkYellow_16_w600),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  SignUpViewModel createViewModel() => SignUpViewModel();
}
