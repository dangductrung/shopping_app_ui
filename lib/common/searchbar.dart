import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shopping_app/theme/ui_color.dart';
import 'package:shopping_app/extensions/size_ext.dart';
import 'package:shopping_app/theme/ui_text_style.dart';

class SearchBar extends StatelessWidget {
  const SearchBar({
    this.controller,
    this.focusNode,
  });

  final TextEditingController controller;
  final FocusNode focusNode;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: DecoratedBox(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.0.h), color: UIColor.scaffoldBackground),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.0.w, vertical: 5.0.h),
          child: Row(
            children: [
              const Icon(CupertinoIcons.search, color: UIColor.searchIconColor),
              Expanded(
                child: CupertinoTextField(
                  placeholder: "Bạn tìm kiếm gì hôm nay?",
                  controller: controller,
                  focusNode: focusNode,
                  style: UITextStyle.mediumLightShadeGray_16_w400,
                  cursorColor: UIColor.searchCursorColor,
                  decoration: null,
                ),
              ),
              GestureDetector(
                onTap: controller.clear,
                child: Icon(
                  CupertinoIcons.clear_thick_circled,
                  color: UIColor.searchIconColor,
                  size: 24.0.h,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
