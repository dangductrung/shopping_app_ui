import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:keyboard_service/keyboard_service.dart';
import 'package:shopping_app/generated/assets.gen.dart';
import 'package:shopping_app/pages/signup/sign_up_view_model.dart';
import 'package:shopping_app/shared/base/base_view_state.dart';
import 'package:shopping_app/theme/ui_color.dart';
import 'package:shopping_app/theme/ui_text_style.dart';
import 'package:shopping_app/extensions/size_ext.dart';

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
          padding: EdgeInsets.symmetric(horizontal: 20.0.w, vertical: height * 15),
          child: Form(
            child: Column(
              children: <Widget>[
                Assets.icons.icLogo.image(height: 120.0.h, width: 120.0.h),
                const SizedBox(
                  height: 16.0,
                ),
                Container(
                  margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                  child: Text("Đăng ký ngay để nhận thêm nhiều ưu đãi", style: UITextStyle.black54_16_w400),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: height),
                  child: TextFormField(
                      autocorrect: false,
                      style: UITextStyle.mediumBlack_16_w400,
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(vertical: 15.0.h, horizontal: 10.0.w),
                          border: const OutlineInputBorder(),
                          hintText: "Tên đăng nhập",
                          labelText: "Tên đăng nhập",
                          labelStyle: UITextStyle.mediumLightShadeGray_16_w400,
                          focusedBorder: const OutlineInputBorder(borderSide: BorderSide())),
                      onChanged: viewModel.onUsernameChanged),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: height),
                  child: TextFormField(
                    autocorrect: false,
                    obscureText: true,
                    style: UITextStyle.mediumBlack_16_w400,
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(vertical: 15.0.h, horizontal: 10.0.w),
                        border: const OutlineInputBorder(),
                        hintText: "Mật khẩu",
                        labelText: "Mật khẩu",
                        labelStyle: UITextStyle.mediumLightShadeGray_16_w400,
                        focusedBorder: const OutlineInputBorder()),
                    onChanged: viewModel.onPwdChanged,
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: height),
                  child: TextFormField(
                      autocorrect: false,
                      obscureText: true,
                      style: UITextStyle.mediumBlack_16_w400,
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(vertical: 15.0.h, horizontal: 10.0.w),
                          border: const OutlineInputBorder(),
                          hintText: "Nhập lại mật khẩu",
                          labelText: "Xác nhận mật khẩu",
                          labelStyle: UITextStyle.mediumLightShadeGray_16_w400,
                          focusedBorder: const OutlineInputBorder()),
                      onChanged: viewModel.onConfirmPwdChanged),
                ),
                SizedBox(
                  height: 16.0.h,
                ),
                GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: viewModel.onRegisterClicked,
                  child: Container(
                    height: 60.0.h,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.0.h),
                      color: UIColor.orangeBtn,
                    ),
                    child: Center(
                      child: Text("Đăng ký", style: UITextStyle.white_16_w400),
                    ),
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
