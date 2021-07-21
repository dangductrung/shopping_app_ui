import 'package:json_annotation/json_annotation.dart';

part 'notification_model.g.dart';

@JsonSerializable()
class NotificationModel {
  @JsonKey(name: "id")
  int id;
  @JsonKey(name: "type")
  String type;
  @JsonKey(name: "body")
  String body;
  @JsonKey(name: "title")
  String title;
  @JsonKey(name: "is_read")
  bool is_read;
  @JsonKey(name: "created_at")
  DateTime created_at;
  @JsonKey(name: "link")
  String link;

  NotificationModel({this.id, this.type, this.body, this.title, this.is_read, this.created_at, this.link});

  factory NotificationModel.fromJson(Map<String, dynamic> json) => _$NotificationModelFromJson(json);
  Map<String, dynamic> toJson() => _$NotificationModelToJson(this);
}
