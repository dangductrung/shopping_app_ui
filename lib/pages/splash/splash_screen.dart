import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:shopping_app/extensions/size_ext.dart';
import 'package:shopping_app/generated/assets.gen.dart';
import 'package:shopping_app/helpers/auth_helper.dart';
import 'package:shopping_app/injector.dart';
import 'package:shopping_app/pages/bottom_bar/bottombar.dart';
import 'package:shopping_app/pages/signin/signin.dart';
import 'package:shopping_app/theme/ui_color.dart';
import 'package:shopping_app/theme/ui_text_style.dart';
import 'package:shopping_app/extensions/size_ext.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  AnimationController controller;

  @override
  void initState() {
    SizeUtil().init();
    UITextStyle.initUITextStyle();
    configEasyLoading();
    WidgetsBinding.instance.addPostFrameCallback((_) => gotoLogin());

    super.initState();
    controller = AnimationController(vsync: this, duration: const Duration(seconds: 2));
    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: controller,
      child: Center(
        child: Assets.icons.icLogo.image(height: 120.0.h, width: 120.0.h),
      ),
    );
  }

  Future<void> gotoLogin() async {
    await Future.delayed(const Duration(seconds: 3), () {
      if (injector<AuthHelper>().isLogined()) {
        Get.offAll(BottomBar());
      } else {
        Get.offAll(SignIn());
      }
    });
  }

  void configEasyLoading() {
    EasyLoading.instance
      ..indicatorType = EasyLoadingIndicatorType.ring
      ..loadingStyle = EasyLoadingStyle.custom
      ..maskType = EasyLoadingMaskType.black
      ..indicatorSize = 45.0.h
      ..radius = 10.0.h
      ..backgroundColor = Colors.white
      ..indicatorColor = UIColor.yellow
      ..textColor = UIColor.mediumBlack
      ..progressColor = UIColor.yellow
      ..textStyle = UITextStyle.mediumBlack_16_w400
      ..userInteractions = false;
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
