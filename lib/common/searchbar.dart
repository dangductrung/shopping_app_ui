import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shopping_app/theme/ui_color.dart';

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
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: UIColor.scaffoldBackground),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 5,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              const Icon(CupertinoIcons.search, color: UIColor.searchIconColor),
              Expanded(
                child: CupertinoTextField(
                  placeholder: "Bạn tìm kiếm gì hôm nay?",
                  controller: controller,
                  focusNode: focusNode,
                  // style: Styles.searchText,
                  cursorColor: UIColor.searchCursorColor,
                  decoration: null,
                ),
              ),
              GestureDetector(
                onTap: controller.clear,
                child: const Icon(
                  CupertinoIcons.clear_thick_circled,
                  color: UIColor.searchIconColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
