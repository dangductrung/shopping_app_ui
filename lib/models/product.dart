import 'package:json_annotation/json_annotation.dart';

part 'product.g.dart';

@JsonSerializable()
class Product {
  @JsonKey(name: "id")
  int id;
  @JsonKey(name: "name")
  String name;
  @JsonKey(name: "image")
  String image;
  @JsonKey(name: "brand")
  String brand;
  @JsonKey(name: "from")
  String from;
  @JsonKey(name: "link")
  String link;
  @JsonKey(name: "current_price")
  double price;
  @JsonKey(name: "isFollow")
  bool isFollow;
  @JsonKey(name: "isNew")
  bool isNew;
  @JsonKey(name: "followId")
  int followId;
  @JsonKey(name: "created_at")
  DateTime createdAt;

  Product({this.id, this.name, this.image, this.brand, this.from, this.link, this.price, this.isFollow, this.isNew, this.followId, this.createdAt});

  factory Product.fromJson(Map<String, dynamic> json) => _$ProductFromJson(json);
  Map<String, dynamic> toJson() => _$ProductToJson(this);
}
