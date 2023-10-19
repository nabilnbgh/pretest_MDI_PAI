import 'package:json_annotation/json_annotation.dart';
import 'coordinates.dart';
part 'address.g.dart';

@JsonSerializable()
class Address {
  String? address;
  String? city;
  Coordinates? coordinates;
  String? postalCode;
  String? state;

  Address({
    this.address,
    this.city,
    this.coordinates,
    this.postalCode,
    this.state,
  });

  factory Address.fromJson(Map<String, dynamic> json) => _$AddressFromJson(json);

  Map<String, dynamic> toJson() =>_$AddressToJson(this);
}
