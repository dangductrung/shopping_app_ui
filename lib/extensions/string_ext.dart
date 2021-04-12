import 'package:easy_localization/easy_localization.dart';

extension StringExt on String {
  String trans({List<String> args, Map<String, String> namedArgs}) {
    return this.tr(args: args, namedArgs: namedArgs);
  }

  String get inCaps => '${this[0].toUpperCase()}${substring(1)}';
}
