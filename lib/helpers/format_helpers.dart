import 'package:easy_localization/easy_localization.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class FormatHelper {
  FormatHelper._();

  static String formatTime(int second) {
    return "${((second / 3600) % 24).floor().toString().padLeft(2, "0")}:${((second / 60) % 60).floor().toString().padLeft(2, "0")}:${(second % 60).floor().toString().padLeft(2, "0")}";
  }

  static String formatDateTime(DateTime dateTime, {String pattern = "yyyy-MM-ddTHH:mm:ss+07:00"}) {
    if (dateTime == null) return "";
    final DateFormat formatter = DateFormat(pattern, EasyLocalization.of(Get.context).locale.languageCode);
    return formatter.format(dateTime);
  }

  static String moneyFormat(double number) {
    final numberFormat = NumberFormat.currency(customPattern: '###,###,###,###,##0.00', locale: 'vi');
    return numberFormat.format(number);
  }
}
