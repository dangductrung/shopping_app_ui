import 'package:json_annotation/json_annotation.dart';

part 'statistic.g.dart';

@JsonSerializable()
class Statistic {
  @JsonKey(name: "shopee")
  List<String> shopee;
  @JsonKey(name: "tiki")
  List<String> tiki;

  Statistic({this.shopee, this.tiki});

  factory Statistic.fromJson(Map<String, dynamic> json) => _$StatisticFromJson(json);
  Map<String, dynamic> toJson() => _$StatisticToJson(this);
}
