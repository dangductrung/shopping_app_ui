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
    super.build(context);

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
                    Assets.icons.icLogo.image(height: 100.0.h, width: 100.0.h),
                    SizedBox(
                      height: 16.0.h,
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 10.0.h),
                      child: TextFormField(
                        style: UITextStyle.mediumBlack_16_w400,
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(vertical: 15.0.h, horizontal: 10.0.w),
                            border: const OutlineInputBorder(),
                            hintText: "T??n ????ng nh???p",
                            labelText: "T??n ????ng nh???p",
                            labelStyle: UITextStyle.mediumLightShadeGray_16_w400,
                            focusedBorder: const OutlineInputBorder()),
                        onChanged: viewModel.onUsernameChanged,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 10.0.h),
                      child: TextFormField(
                        obscureText: true,
                        style: UITextStyle.mediumBlack_16_w400,
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(vertical: 15.0.h, horizontal: 10.0.w),
                            border: const OutlineInputBorder(),
                            hintText: "M???t kh???u",
                            labelText: "M???t kh???u",
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
                        height: 50.0.h,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.0.h),
                          color: UIColor.orangeBtn,
                        ),
                        child: Center(
                          child: Text("????ng nh???p", style: UITextStyle.white_16_w400),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 16.0.h,
                    ),
                    Row(
                      children: <Widget>[
                        Text(
                          "B???n ch??a c?? t??i kho???n? ",
                          style: UITextStyle.grayText_16_w400,
                        ),
                        Expanded(
                          child: GestureDetector(
                            behavior: HitTestBehavior.translucent,
                            onTap: viewModel.onSignUpClicked,
                            child: Text(
                              "????ng k?? ngay",
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
