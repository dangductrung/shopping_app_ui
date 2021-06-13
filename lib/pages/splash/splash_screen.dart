import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopping_app/extensions/size_ext.dart';
import 'package:shopping_app/generated/assets.gen.dart';
import 'package:shopping_app/helpers/auth_helper.dart';
import 'package:shopping_app/injector.dart';
import 'package:shopping_app/pages/bottom_bar/bottombar.dart';
import 'package:shopping_app/pages/signin/signin.dart';
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
        child: Assets.icons.icLogo.image(height: 180.0.h, width: 180.0.h),
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

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
