import 'package:json_annotation/json_annotation.dart';
import 'package:pandawatest/model/response/user/user.dart';
part 'loginresponse.g.dart';

@JsonSerializable()
class LoginResponse {
  User user;
  String token;
  LoginResponse({required this.user, required this.token});

  factory LoginResponse.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseFromJson(json);

  Map<String, dynamic> toJson() => _$LoginResponseToJson(this);
}
