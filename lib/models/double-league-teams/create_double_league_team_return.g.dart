// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_double_league_team_return.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateDoubleLeagueTeamReturn _$CreateDoubleLeagueTeamReturnFromJson(
        Map<String, dynamic> json) =>
    CreateDoubleLeagueTeamReturn(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      organisationId: (json['organisationId'] as num).toInt(),
      leagueId: (json['leagueId'] as num).toInt(),
    );

Map<String, dynamic> _$CreateDoubleLeagueTeamReturnToJson(
        CreateDoubleLeagueTeamReturn instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'createdAt': instance.createdAt.toIso8601String(),
      'organisationId': instance.organisationId,
      'leagueId': instance.leagueId,
    };
