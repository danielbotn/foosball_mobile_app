// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'team_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TeamModel _$TeamModelFromJson(Map<String, dynamic> json) => TeamModel(
      id: (json['id'] as num).toInt(),
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      email: json['email'] as String,
      photoUrl: json['photoUrl'] as String,
      teamName: json['teamName'] as String,
      userId: (json['userId'] as num).toInt(),
      teamId: (json['teamId'] as num).toInt(),
    );

Map<String, dynamic> _$TeamModelToJson(TeamModel instance) => <String, dynamic>{
      'id': instance.id,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'email': instance.email,
      'photoUrl': instance.photoUrl,
      'teamName': instance.teamName,
      'userId': instance.userId,
      'teamId': instance.teamId,
    };
