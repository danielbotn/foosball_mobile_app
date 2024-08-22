// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserResponse _$UserResponseFromJson(Map<String, dynamic> json) => UserResponse(
      id: (json['id'] as num).toInt(),
      email: json['email'] as String,
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      currentOrganisationId: (json['currentOrganisationId'] as num?)?.toInt(),
      photoUrl: json['photoUrl'] as String,
      isAdmin: json['isAdmin'] as bool?,
      isDeleted: json['isDeleted'] as bool,
    );

Map<String, dynamic> _$UserResponseToJson(UserResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'createdAt': instance.createdAt.toIso8601String(),
      'currentOrganisationId': instance.currentOrganisationId,
      'photoUrl': instance.photoUrl,
      'isAdmin': instance.isAdmin,
      'isDeleted': instance.isDeleted,
    };
