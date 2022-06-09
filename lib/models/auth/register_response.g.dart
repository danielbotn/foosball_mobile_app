// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'register_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RegisterResponse _$RegisterResponseFromJson(Map<String, dynamic> json) =>
    RegisterResponse(
      id: json['id'] as int,
      email: json['email'] as String,
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      currentOrganisationId: json['currentOrganisationId'] as int?,
      photoUrl: json['photoUrl'] as String?,
    );

Map<String, dynamic> _$RegisterResponseToJson(RegisterResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'createdAt': instance.createdAt.toIso8601String(),
      'currentOrganisationId': instance.currentOrganisationId,
      'photoUrl': instance.photoUrl,
    };
