import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:shopping_app/theme/ui_color.dart';
import 'package:shopping_app/extensions/size_ext.dart';
import 'package:shopping_app/theme/ui_text_style.dart';

class SearchBar extends StatefulWidget {
  const SearchBar({
    this.controller,
    this.focusNode,
  });

  final TextEditingController controller;
  final FocusNode focusNode;

  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: DecoratedBox(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.0.h), color: UIColor.scaffoldBackground),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 4.0.h, horizontal: 8.0.w),
          child: Row(
            children: [
              const Icon(CupertinoIcons.search, color: UIColor.searchIconColor),
              Expanded(
                child: TextField(
                  controller: widget.controller,
                  focusNode: widget.focusNode,
                  autocorrect: false,
                  cursorColor: UIColor.searchCursorColor,
                  decoration: InputDecoration(
                    isDense: true,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(vertical: 8.0.h, horizontal: 8.0.w),
                    hintText: "Bạn tìm kiếm gì hôm nay?",
                  ),
                  onChanged: (value) {
                    setState(() {});
                  },
                ),
              ),
              if (!GetUtils.isNullOrBlank(widget.controller.text))
                GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: () {
                    setState(() {
                      widget.controller.text = "";
                    });
                  },
                  child: Center(
                    child: Icon(
                      CupertinoIcons.clear,
                      color: UIColor.searchIconColor,
                      size: 18.0.h,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
