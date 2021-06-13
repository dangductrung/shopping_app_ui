import 'package:get/get.dart';

extension SizerExt on double {
  double get h => SizeUtil.height(this);

  double get w => SizeUtil.width(this);

  double get sp => SizeUtil.sp(this);
}

class SizeUtil {
  static const double widthDefault = 375;
  static const double heightDefault = 812;

  static double _width;
  static double _height;
  static DeviceType _deviceType;

  void init() {
    try {
      _width = Get.width;
      _height = Get.height;
    } catch (exception) {
      _width = 375;
      _height = 812;
    }

    if (_width < 600) {
      _deviceType = DeviceType.mobile;
    } else {
      _deviceType = DeviceType.tablet;
    }
  }

  static double height(double i) {
    return _height * i / heightDefault;
  }

  static double width(double i) {
    return _width * i / widthDefault;
  }

  static double sp(double i) {
    return (_width / widthDefault) * i * (_deviceType == DeviceType.tablet ? 9/13 : 1);
  }

  static DeviceType get deviceType => _deviceType;
}

enum DeviceType {
  mobile,
  tablet,
}