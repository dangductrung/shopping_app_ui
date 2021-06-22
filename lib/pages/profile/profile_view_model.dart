import 'package:shopping_app/backend/services/profile/profile_service.dart';
import 'package:shopping_app/helpers/auth_helper.dart';
import 'package:shopping_app/injector.dart';
import 'package:shopping_app/models/profile.dart';
import 'package:shopping_app/shared/base/base_view_model.dart';
import 'package:get/get.dart';

class ProfileViewModel extends BaseViewModel {
  final _profile = Profile().obs;
  Profile get profile => _profile.value;

  @override
  void initState() {
    getData();
    super.initState();
  }

  void getData() {
    call(() async {
      _profile.value = await injector<ProfileService>().getInfo();
    });
  }

  @override
  void disposeState() {
    _profile.close();
    super.disposeState();
  }

  void onLogoutClicked() {
    injector<AuthHelper>().logout();
  }
}
