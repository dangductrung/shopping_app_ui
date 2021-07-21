import 'package:flutter/material.dart';
import 'package:shopping_app/pages/favoriteList/favorite_list.dart';
import 'package:shopping_app/pages/home/home.dart';
import 'package:shopping_app/pages/notification/notification_list.dart';
import 'package:shopping_app/pages/profile/profile_screen.dart';
import 'package:shopping_app/shared/base/base_view_model.dart';
import 'package:get/get.dart';

class BottomBarViewModel extends BaseViewModel {
  final List<Widget> pages = [
    HomeScreen(), // see the FrontPage class
    NotificationList(),
    FavoriteList(),
    ProfileScreen(),
  ];
  final pageController = PageController();

  final _index = 0.obs;
  int get index => _index.value;

  // ignore: use_setters_to_change_properties
  void onBarTapped(int value) {
    _index.value = value;
    pageController.jumpToPage(value);
  }
}
