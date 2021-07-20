import 'package:json_annotation/json_annotation.dart';

part 'history_product.g.dart';

@JsonSerializable()
class HistoryProduct {
  @JsonKey(name: "price")
  double price;
  @JsonKey(name: "delta")
  double delta;
  @JsonKey(name: "created_at")
  DateTime createdAt;

  HistoryProduct({this.price, this.delta, this.createdAt});

  factory HistoryProduct.fromJson(Map<String, dynamic> json) => _$HistoryProductFromJson(json);
  Map<String, dynamic> toJson() => _$HistoryProductToJson(this);
}
