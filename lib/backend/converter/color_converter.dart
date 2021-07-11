import 'dart:ui';

import 'package:json_annotation/json_annotation.dart';

class ColorConverter implements JsonConverter<Color, dynamic> {
  const ColorConverter();

  @override
  Color fromJson(dynamic json) {
    if (json is String) {
      return Color(int.tryParse(json));
    }
    return null;
  }

  @override
  dynamic toJson(Color object) {
    if (object != null) {
      return object.toString();
    } else {
      return null;
    }
  }
}
