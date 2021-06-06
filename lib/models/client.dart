import 'package:json_annotation/json_annotation.dart';

part 'client.g.dart';

@JsonSerializable()
class Client {
  @JsonKey(name: "access_token")
  String token;
  @JsonKey(name: "expired_at")
  DateTime expiredAt;

  Client({this.token, this.expiredAt});

  factory Client.fromJson(Map<String, dynamic> json) => _$ClientFromJson(json);
  Map<String, dynamic> toJson() => _$ClientToJson(this);

  bool isExpired() => DateTime.now().isAfter(expiredAt) ?? true;
}
