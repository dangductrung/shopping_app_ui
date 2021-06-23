import 'package:flutter/material.dart';
import 'package:shopping_app/backend/services/profile/profile_service.dart';
import 'package:shopping_app/helpers/toast_helper.dart';
import 'package:shopping_app/injector.dart';
import 'package:shopping_app/models/profile.dart';
import 'package:shopping_app/shared/base/base_view_model.dart';
import 'package:get/get.dart';

class EditProfileViewModel extends BaseViewModel {
  Profile profile = Profile();

  Function() onUpdateSuccess;

  final _email = TextEditingController().obs;
  final _phone = TextEditingController().obs;
  final _name = TextEditingController().obs;

  TextEditingController get email => _email.value;
  TextEditingController get phone => _phone.value;
  TextEditingController get name => _name.value;

  @override
  void initState() {
    getData();
    super.initState();
  }

  void getData() {
    call(() async {
      profile = await injector<ProfileService>().getInfo();
      updateProfile();
    });
  }

  void updateProfile() {
    _email.value.text = profile?.email ?? "";
    _phone.value.text = profile?.phone ?? "";
    _name.value.text = profile?.name ?? "";
  }

  @override
  void disposeState() {
    email.dispose();
    phone.dispose();
    name.dispose();
    _email.close();
    _phone.close();
    _name.close();
    super.disposeState();
  }

  void onSaveBtnClicked() {
    final Map<String, dynamic> params = {};
    params["name"] = name?.text ?? "";
    params["phone"] = phone?.text ?? "";
    params["email"] = email?.text ?? "";

    call(() async {
      await injector<ProfileService>().updateProfile(params);
      if (onUpdateSuccess != null) {
        onUpdateSuccess();
      }
      ToastHelper.showToast(msg: "Success");
    });
  }
}
