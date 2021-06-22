import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopping_app/generated/assets.gen.dart';
import 'package:shopping_app/pages/profile/edit_profile.dart';
import 'package:shopping_app/pages/profile/profile_view_model.dart';
import 'package:shopping_app/shared/base/base_view_state.dart';
import 'package:shopping_app/theme/ui_color.dart';
import 'package:shopping_app/theme/ui_text_style.dart';
import 'package:shopping_app/extensions/size_ext.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends BaseViewState<ProfileScreen, ProfileViewModel> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: UIColor.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
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
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => EditProfile()),
              );
            },
            child: Padding(
              padding: EdgeInsets.only(right: 16.0.w),
              child: Center(
                child: Icon(
                  Icons.edit,
                  size: 24.0.h,
                ),
              ),
            ),
          )
        ],
        title: Text(
          "Thông tin tài khoản",
          style: UITextStyle.mediumBlack_16_w400.copyWith(fontSize: 20, color: Colors.white),
        ),
      ),
      body: Obx(
        () => SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 16.0.h,
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(60.0.h),
                child: Assets.icons.icLogo.image(
                  height: 120.0.h,
                  width: 120.0.h,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 16.0.h),
                child: Text(
                  !GetUtils.isNullOrBlank(viewModel.profile?.name ?? "") ? viewModel?.profile?.name : "Chưa cập nhật",
                  style: GetUtils.isNullOrBlank(viewModel.profile?.name ?? "") ? UITextStyle.mediumLightShadeGray_16_w400 : UITextStyle.mediumBlack_16_w400,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0.w, vertical: 16.0.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Điểm tích lũy ',
                      style: UITextStyle.mediumBlack_16_w400,
                    ),
                    Row(
                      children: [
                        Assets.imgs.dollar.image(height: 20.0.h, width: 20.0.h),
                        SizedBox(
                          width: 8.0.w,
                        ),
                        Text(
                          viewModel.profile?.point?.toString() ?? "0",
                          style: UITextStyle.lightGreen_16_w600,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0.w, vertical: 16.0.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Số điện thoại ',
                      style: UITextStyle.mediumBlack_16_w400,
                    ),
                    Text(
                      !GetUtils.isNullOrBlank(viewModel.profile?.phone ?? "") ? viewModel?.profile?.phone : "Chưa cập nhật",
                      style: GetUtils.isNullOrBlank(viewModel.profile?.phone ?? "") ? UITextStyle.mediumLightShadeGray_16_w400 : UITextStyle.mediumBlack_16_w400,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0.w, vertical: 16.0.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Email ',
                      style: UITextStyle.mediumBlack_16_w400,
                    ),
                    Text(
                      !GetUtils.isNullOrBlank(viewModel.profile?.email ?? "") ? viewModel?.profile?.email : "Chưa cập nhật",
                      style: GetUtils.isNullOrBlank(viewModel.profile?.email) ? UITextStyle.mediumLightShadeGray_16_w400 : UITextStyle.mediumBlack_16_w400,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 16.0.h,
              ),
              InkWell(
                onTap: viewModel.onLogoutClicked,
                child: Container(
                    height: 50.0.h,
                    width: double.infinity,
                    margin: EdgeInsets.symmetric(horizontal: 16.0.w),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.0.h),
                      color: UIColor.lightShadeGray,
                    ),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 16.0.w,
                        ),
                        Icon(
                          Icons.logout,
                          size: 24.0.h,
                          color: UIColor.red,
                        ),
                        SizedBox(
                          width: 8.0.w,
                        ),
                        Text(
                          "Đăng xuất",
                          style: UITextStyle.mediumBlack_16_w400,
                        )
                      ],
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  ProfileViewModel createViewModel() => ProfileViewModel();
}
