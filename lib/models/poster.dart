import 'dart:ui';

import 'package:json_annotation/json_annotation.dart';
import 'package:shopping_app/backend/converter/color_converter.dart';

part 'poster.g.dart';

@JsonSerializable()
class Poster {
  @JsonKey(name: "id")
  int id;
  @JsonKey(name: "title")
  String title;
  @JsonKey(name: "bg_color_start")
  @ColorConverter()
  Color bgColorStart;
  @JsonKey(name: "bg_color_end")
  @ColorConverter()
  Color bgColorEnd;
  @JsonKey(name: "txt_color")
  @ColorConverter()
  Color txtColor;

  Poster({this.id, this.title, this.bgColorStart, this.bgColorEnd, this.txtColor});

  factory Poster.fromJson(Map<String, dynamic> json) => _$PosterFromJson(json);
  Map<String, dynamic> toJson() => _$PosterToJson(this);
}
