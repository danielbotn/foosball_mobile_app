// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'double_league_player_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DoubleLeaguePlayerModel _$DoubleLeaguePlayerModelFromJson(
        Map<String, dynamic> json) =>
    DoubleLeaguePlayerModel(
      id: json['id'] as int,
      userId: json['userId'] as int,
      doubleLeagueTeamId: json['doubleLeagueTeamId'] as int,
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      email: json['email'] as String,
      teamId: json['teamId'] as int,
      teamName: json['teamName'] as String?,
    );

Map<String, dynamic> _$DoubleLeaguePlayerModelToJson(
        DoubleLeaguePlayerModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'doubleLeagueTeamId': instance.doubleLeagueTeamId,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'email': instance.email,
      'teamId': instance.teamId,
      'teamName': instance.teamName,
    };
