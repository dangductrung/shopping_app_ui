import 'package:get/get.dart';

extension DoubleExt on double {
  String toSignedString({int decimal}) {
    String result = "0";
    if (GetUtils.isNullOrBlank(this) || this == 0) {
      return result;
    }
    if ((this - floor()) == 0) {
      result = toStringAsFixed(decimal ?? 0);
    }
    result = toStringAsFixed(decimal ?? 1);

    final List<String> tokens = result.split(".");

    if (tokens.length > 1) {
      while (tokens[1].endsWith("0")) {
        tokens[1] = tokens[1].substring(0, tokens[1].length - 1);
      }
      result = "${tokens[0]}.${tokens[1]}";
      if (tokens[1].isEmpty) {
        result = result.replaceAll(".", "");
      }
    }

    return result;
  }
}
