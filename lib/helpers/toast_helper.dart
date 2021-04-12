import 'package:fluttertoast/fluttertoast.dart';

class ToastHelper {
  static void showToast({String msg}) {
    Fluttertoast.showToast(msg: msg, fontSize: 14.0);
  }
}
