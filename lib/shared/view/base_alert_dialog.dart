import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopping_app/extensions/string_ext.dart';
import 'package:shopping_app/generated/locale_keys.g.dart';
import 'package:shopping_app/theme/ui_color.dart';
import 'package:shopping_app/theme/ui_text_style.dart';

class BaseAlertDialog extends StatelessWidget {
  final Widget body;
  final String title;
  final String confirmTitle;
  final String cancelTitle;
  final Function() onConfirmBtnClicked;
  final Function() onCancelBtnClicked;

  const BaseAlertDialog({this.body, this.title, this.confirmTitle, this.cancelTitle, this.onConfirmBtnClicked, this.onCancelBtnClicked});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Container(
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(5.0)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 16.0),
              if (!GetUtils.isNullOrBlank(title))
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      title,
                      style: UITextStyle.lightGreen_16_w700,
                    ),
                    const SizedBox(height: 16.0),
                  ],
                ),
              Container(
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(5.0)),
                child: body,
              ),
              const SizedBox(height: 16.0),
              Container(
                width: double.infinity,
                height: 1.0,
                color: UIColor.lightShadeGray,
              ),
              Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: onCancelBtnClicked,
                      child: Container(
                        height: 40.0,
                        decoration: const BoxDecoration(borderRadius: BorderRadius.only(bottomLeft: Radius.circular(5.0))),
                        child: Center(
                            child: Text(
                          LocaleKeys.cancel.trans(),
                          style: UITextStyle.lightGreen_16_w400,
                        )),
                      ),
                    ),
                  ),
                  Container(
                    height: 40.0,
                    width: 1.0,
                    color: UIColor.lightShadeGray,
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: onConfirmBtnClicked,
                      child: Container(
                        height: 40.0,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(bottomRight: Radius.circular(5.0)),
                          color: UIColor.lightGreen,
                        ),
                        child: Center(
                            child: Text(
                          LocaleKeys.ok.trans(),
                          style: UITextStyle.white_16_w400,
                        )),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
