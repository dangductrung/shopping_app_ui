import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:keyboard_service/keyboard_service.dart';
import 'package:shopping_app/pages/profile/edit_profile_view_model.dart';
import 'package:shopping_app/shared/base/base_view_state.dart';
import 'package:shopping_app/theme/ui_color.dart';
import 'package:shopping_app/theme/ui_text_style.dart';
import 'package:shopping_app/extensions/size_ext.dart';

class EditProfile extends StatefulWidget {
  final Function() onUpdateSuccess;

  const EditProfile({this.onUpdateSuccess});

  @override
  EditProfileState createState() => EditProfileState();
}

class EditProfileState extends BaseViewState<EditProfile, EditProfileViewModel> {
  @override
  void loadArguments() {
    viewModel.onUpdateSuccess = widget?.onUpdateSuccess;
    super.loadArguments();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    final height = MediaQuery.of(context).size.height / 100;
    return Obx(
      () => KeyboardAutoDismiss(
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
              "Chỉnh sửa thông tin",
              style: UITextStyle.white_18_w400,
            ),
          ),
          // CustomAppBar(),
          body: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 30, vertical: height * 2),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 50.0.h,
                  child: TextField(
                    controller: viewModel.name,
                    style: UITextStyle.mediumBlack_16_w400,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      hintText: "Nhập họ tên của bạn",
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
                    controller: viewModel.email,
                    style: UITextStyle.mediumBlack_16_w400,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      hintText: "Nhập email của bạn",
                      hintStyle: UITextStyle.mediumLightShadeGray_16_w400,
                      labelStyle: UITextStyle.mediumBlack_16_w400,
                      contentPadding: EdgeInsets.symmetric(horizontal: 16.0.w),
                      focusedBorder: const OutlineInputBorder(),
                    ),
                  ),
                ),
                SizedBox(
                  height: 16.0.h,
                ),
                SizedBox(
                  height: 50.0.h,
                  child: TextField(
                    controller: viewModel.phone,
                    style: UITextStyle.mediumBlack_16_w400,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      hintText: "Nhập số điện thoại",
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
                InkWell(
                  onTap: viewModel.onSaveBtnClicked,
                  child: Container(
                    height: 50.0.h,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.0.h),
                      color: UIColor.yellow,
                    ),
                    child: Center(
                      child: Text(
                        "Lưu",
                        style: UITextStyle.white_18_w400,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  EditProfileViewModel createViewModel() => EditProfileViewModel();
}
