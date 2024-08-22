// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'team-member-model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TeamMemberModel _$TeamMemberModelFromJson(Map<String, dynamic> json) =>
    TeamMemberModel(
      id: (json['id'] as num).toInt(),
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      email: json['email'] as String,
    );

Map<String, dynamic> _$TeamMemberModelToJson(TeamMemberModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'email': instance.email,
    };
