import 'package:flutter/material.dart';
import 'package:keyboard_service/keyboard_service.dart';
import 'package:shopping_app/pages/report/report_view_model.dart';
import 'package:shopping_app/shared/base/base_view_state.dart';
import 'package:shopping_app/extensions/size_ext.dart';
import 'package:shopping_app/theme/ui_color.dart';
import 'package:shopping_app/theme/ui_text_style.dart';

class ReportPage extends StatefulWidget {
  final int id;

  const ReportPage({this.id});

  @override
  _ReportPageState createState() => _ReportPageState();
}

class _ReportPageState extends BaseViewState<ReportPage, ReportViewModel> {
  @override
  void loadArguments() {
    viewModel.id = widget?.id;
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
            "Báo lỗi",
            style: UITextStyle.white_18_w400,
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
              Text(
                "Tiêu đề:",
                style: UITextStyle.mediumBlack_16_w700,
              ),
              SizedBox(
                height: 4.0.h,
              ),
              SizedBox(
                height: 50.0.h,
                child: TextField(
                  controller: viewModel.title,
                  style: UITextStyle.mediumBlack_16_w400,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    hintText: "Tiêu đề",
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
              Text(
                "Nội dung:",
                style: UITextStyle.mediumBlack_16_w700,
              ),
              SizedBox(
                height: 4.0.h,
              ),
              TextField(
                controller: viewModel.content,
                style: UITextStyle.mediumBlack_16_w400,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  hintText: "Nội dung báo lỗi",
                  hintStyle: UITextStyle.mediumLightShadeGray_16_w400,
                  labelStyle: UITextStyle.mediumBlack_16_w400,
                  focusedBorder: const OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(horizontal: 16.0.w, vertical: 16.0.h),
                ),
                maxLines: 5,
              ),
              const Spacer(),
              InkWell(
                onTap: viewModel.onSubmitClicked,
                child: Container(
                  height: 50.0.h,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.0.h),
                    color: UIColor.yellow,
                  ),
                  child: Center(
                    child: Text(
                      "Gửi",
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
  ReportViewModel createViewModel() => ReportViewModel();
}
