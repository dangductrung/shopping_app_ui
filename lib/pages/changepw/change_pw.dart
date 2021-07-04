import 'package:flutter/material.dart';
import 'package:keyboard_service/keyboard_service.dart';
import 'package:shopping_app/pages/changepw/change_pw_view_model.dart';
import 'package:shopping_app/shared/base/base_view_state.dart';
import 'package:shopping_app/extensions/size_ext.dart';
import 'package:shopping_app/theme/ui_color.dart';
import 'package:shopping_app/theme/ui_text_style.dart';

class ChangePw extends StatefulWidget {
  final Function() onChangePwSuccess;

  const ChangePw({this.onChangePwSuccess});

  @override
  _ChangePwState createState() => _ChangePwState();
}

class _ChangePwState extends BaseViewState<ChangePw, ChangePwViewModel> {
  @override
  void loadArguments() {
    viewModel.onChangePwSuccess = widget?.onChangePwSuccess;
    super.loadArguments();
  }

  @override
  Widget build(BuildContext context) {
    return KeyboardAutoDismiss(
      scaffold: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          flexibleSpace: Container(
            padding: EdgeInsets.fromLTRB(5.0.w, 14.0.h, 0, 0),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [Color(0xffF12711), Color(0xffF5AF19)],
              ),
            ),
          ),
          title: Text(
            "Đổi mật khẩu",
            style: UITextStyle.mediumBlack_16_w400.copyWith(fontSize: 20, color: Colors.white),
          ),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 16.0.h,
              ),
              SizedBox(
                height: 50.0.h,
                child: TextField(
                  controller: viewModel.oldPw,
                  style: UITextStyle.mediumBlack_16_w400,
                  obscureText: true,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    hintText: "Mật khẩu hiện tại",
                    hintStyle: UITextStyle.mediumLightShadeGray_16_w400,
                    labelStyle: UITextStyle.mediumBlack_16_w400,
                    focusedBorder: const OutlineInputBorder(),
                    contentPadding: EdgeInsets.symmetric(horizontal: 16.0.w),
                  ),
                ),
              ),
              SizedBox(
                height: 16.0.h,
              ),
              SizedBox(
                height: 50.0.h,
                child: TextField(
                  controller: viewModel.newPw,
                  style: UITextStyle.mediumBlack_16_w400,
                  obscureText: true,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    hintText: "Mật khẩu mới",
                    hintStyle: UITextStyle.mediumLightShadeGray_16_w400,
                    labelStyle: UITextStyle.mediumBlack_16_w400,
                    focusedBorder: const OutlineInputBorder(),
                    contentPadding: EdgeInsets.symmetric(horizontal: 16.0.w),
                  ),
                ),
              ),
              SizedBox(
                height: 16.0.h,
              ),
              SizedBox(
                height: 50.0.h,
                child: TextField(
                  controller: viewModel.renewPw,
                  style: UITextStyle.mediumBlack_16_w400,
                  obscureText: true,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    hintText: "Nhập lại mật khẩu mới",
                    hintStyle: UITextStyle.mediumLightShadeGray_16_w400,
                    labelStyle: UITextStyle.mediumBlack_16_w400,
                    focusedBorder: const OutlineInputBorder(),
                    contentPadding: EdgeInsets.symmetric(horizontal: 16.0.w),
                  ),
                ),
              ),
              const Spacer(),
              InkWell(
                onTap: viewModel.onChangePwClicked,
                child: Container(
                  height: 50.0.h,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.0.h),
                    color: UIColor.yellow,
                  ),
                  child: Center(
                    child: Text(
                      "Đổi mật khẩu",
                      style: UITextStyle.white_16_w400,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 32.0.h,
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  ChangePwViewModel createViewModel() => ChangePwViewModel();
}
