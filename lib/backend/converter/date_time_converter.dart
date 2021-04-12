import 'package:json_annotation/json_annotation.dart';

class DateTimeConverter implements JsonConverter<DateTime, dynamic> {
  const DateTimeConverter();

  @override
  DateTime fromJson(dynamic json) {
    if (json is String) {
      return DateTime.parse(json).toLocal();
    }
    return null;
  }

  @override
  dynamic toJson(DateTime object) {
    if (object != null) {
      return object.toUtc()?.toIso8601String();
    } else {
      return null;
    }
  }
}
