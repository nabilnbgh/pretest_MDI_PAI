import 'package:json_annotation/json_annotation.dart';
part 'hair.g.dart';

@JsonSerializable()
class Hair {
  String? color;
  String? type;

  Hair({this.color, this.type});

  factory Hair.fromJson(Map<String, dynamic> json) => _$HairFromJson(json);

  Map<String, dynamic> toJson() => _$HairToJson(this);
}
