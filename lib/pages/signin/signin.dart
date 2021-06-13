import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:keyboard_service/keyboard_service.dart';
import 'package:shopping_app/generated/assets.gen.dart';
import 'package:shopping_app/pages/signin/sign_in_view_model.dart';
import 'package:shopping_app/pages/signup/signup.dart';
import 'package:shopping_app/shared/base/base_view_state.dart';
import 'package:shopping_app/theme/ui_color.dart';
import 'package:shopping_app/theme/ui_text_style.dart';
import 'package:shopping_app/extensions/size_ext.dart';

class SignIn extends StatefulWidget {
  @override
  SignInState createState() => SignInState();
}

class SignInState extends BaseViewState<SignIn, SignInViewModel> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height / 100;
    final width = MediaQuery.of(context).size.width / 100;
    return KeyboardAutoDismiss(
      scaffold: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(
          children: <Widget>[
            Container(
              width: width * 100,
              height: height * 30,
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(280), bottomRight: Radius.circular(120)),
                  border: Border.all(color: UIColor.lightOrange),
                  color: UIColor.lightOrange),
            ),
            Center(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 30.0.w),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Assets.icons.icLogo.image(height: 160.0.h, width: 160.0.h),
                    SizedBox(
                      height: 16.0.h,
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 10.0.h),
                      child: TextFormField(
                        controller: TextEditingController(),
                        style: UITextStyle.mediumBlack_16_w400,
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(vertical: 15.0.h, horizontal: 10.0.w),
                            border: const OutlineInputBorder(),
                            hintText: "Tên đăng nhập",
                            labelText: "Tên đăng nhập",
                            labelStyle: UITextStyle.mediumLightShadeGray_16_w400,
                            focusedBorder: const OutlineInputBorder()),
                        onChanged: viewModel.onUsernameChanged,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 10.0.h),
                      child: TextFormField(
                        obscureText: true,
                        controller: TextEditingController(),
                        style: UITextStyle.mediumBlack_16_w400,
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(vertical: 15.0.h, horizontal: 10.0.w),
                            border: const OutlineInputBorder(),
                            hintText: "Mật khẩu",
                            labelText: "Mật khẩu",
                            labelStyle: UITextStyle.mediumLightShadeGray_16_w400,
                            focusedBorder: const OutlineInputBorder()),
                        onChanged: viewModel.onPassChanged,
                      ),
                    ),
                    SizedBox(
                      height: 16.0.h,
                    ),
                    GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      onTap: viewModel.onBtnClicked,
                      child: Container(
                        height: 60.0.h,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.0.h),
                          color: UIColor.orangeBtn,
                        ),
                        child: Center(
                          child: Text("Đăng nhập", style: UITextStyle.white_16_w400),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 16.0.h,
                    ),
                    Row(
                      children: <Widget>[
                        Text(
                          "Bạn chưa có tài khoản? ",
                          style: UITextStyle.grayText_16_w400,
                        ),
                        Expanded(
                          child: GestureDetector(
                            behavior: HitTestBehavior.translucent,
                            onTap: viewModel.onSignUpClicked,
                            child: Text(
                              "Đăng ký ngay",
                              style: UITextStyle.darkYellow_16_w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  SignInViewModel createViewModel() => SignInViewModel();
}
