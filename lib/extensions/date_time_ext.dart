import 'package:shopping_app/helpers/format_helpers.dart';
import 'package:timeago/timeago.dart' as timeago;

extension DateTimeExt on DateTime {
  String timeAgo({int day = 1, bool isHaveCreatedAt = true}) {
    String result = "";
    if (isHaveCreatedAt) {
      if (DateTime.now().difference(this).inDays > day) {
        result = "Ngày cập nhật: ${FormatHelper.formatDateTime(this, pattern: "dd/MM/yyyy")}";
      } else {
        result = timeago.format(this, allowFromNow: false, locale: 'vi');
      }
    } else {
      result = timeago.format(this, allowFromNow: false, locale: 'vi');
    }
    return result;
  }
}
