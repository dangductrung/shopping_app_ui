import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopping_app/extensions/string_ext.dart';
import 'package:shopping_app/generated/locale_keys.g.dart';
import 'package:shopping_app/theme/ui_color.dart';
import 'package:shopping_app/theme/ui_text_style.dart';

class BaseBottomSheetWidget extends StatelessWidget {
  final String title;
  final Widget body;
  final String confirmTitle;
  final Function() onConfirmBtnClicked;
  final bool isShowConfirmButton;

  const BaseBottomSheetWidget({this.title, this.body, this.confirmTitle, this.onConfirmBtnClicked, this.isShowConfirmButton = true});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: MediaQuery.of(Get.context).viewInsets.bottom),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.0),
        color: UIColor.white,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 16.0),
            if (!GetUtils.isNullOrBlank(title)) Text(title, style: UITextStyle.green_16_w700),
            body,
            if (isShowConfirmButton)
              InkWell(
                onTap: onConfirmBtnClicked,
                child: Container(
                  height: 45.0,
                  width: double.infinity,
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(5.0), color: UIColor.green),
                  child: Center(child: Text(confirmTitle ?? LocaleKeys.ok.trans(), style: UITextStyle.white_16_w400)),
                ),
              ),
            const SizedBox(height: 16.0),
          ],
        ),
      ),
    );
  }
}
