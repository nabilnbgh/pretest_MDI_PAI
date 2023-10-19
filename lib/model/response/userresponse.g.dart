// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'userresponse.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserResponse _$UserResponseFromJson(Map<String, dynamic> json) => UserResponse(
      (json['users'] as List<dynamic>?)
          ?.map((e) => User.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['total'] as int?,
      json['skip'] as int?,
      json['limit'] as int?,
    );

Map<String, dynamic> _$UserResponseToJson(UserResponse instance) =>
    <String, dynamic>{
      'users': instance.users,
      'total': instance.total,
      'skip': instance.skip,
      'limit': instance.limit,
    };
