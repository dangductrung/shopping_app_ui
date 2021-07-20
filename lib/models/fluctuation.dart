import 'package:json_annotation/json_annotation.dart';
import 'package:shopping_app/models/product.dart';

part 'fluctuation.g.dart';

@JsonSerializable()
class Fluctuation {
  @JsonKey(name: "product")
  Product product;
  @JsonKey(name: "delta")
  double delta;

  Fluctuation({this.product, this.delta});

  factory Fluctuation.fromJson(Map<String, dynamic> json) => _$FluctuationFromJson(json);
  Map<String, dynamic> toJson() => _$FluctuationToJson(this);
}
