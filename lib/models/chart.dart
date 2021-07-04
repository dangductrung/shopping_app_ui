import 'package:json_annotation/json_annotation.dart';
import 'package:shopping_app/models/product.dart';

part 'chart.g.dart';

@JsonSerializable()
class Chart {
  @JsonKey(name: "shopee")
  List<Product> shopees;
  @JsonKey(name: "tiki")
  List<Product> tikis;

  Chart({this.shopees, this.tikis});

  factory Chart.fromJson(Map<String, dynamic> json) => _$ChartFromJson(json);
  Map<String, dynamic> toJson() => _$ChartToJson(this);
}
