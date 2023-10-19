import 'package:json_annotation/json_annotation.dart';
import 'package:pandawatest/model/response/user/user.dart';

part 'userresponse.g.dart';

@JsonSerializable()
class UserResponse {
  List<User>? users;
  int? total;
  int? skip;
  int? limit;
  UserResponse(this.users, this.total, this.skip, this.limit);

  factory UserResponse.fromJson(Map<String, dynamic> json) =>
      _$UserResponseFromJson(json);

  Map<String, dynamic> toJson() => _$UserResponseToJson(this);
}
