// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_double_league_matches_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateDoubleLeagueMatchesResponse _$CreateDoubleLeagueMatchesResponseFromJson(
        Map<String, dynamic> json) =>
    CreateDoubleLeagueMatchesResponse(
      id: json['id'] as int,
      teamOneId: json['teamOneId'] as int,
      teamTwoId: json['teamTwoId'] as int,
      leagueId: json['leagueId'] as int,
      startTime: json['startTime'] == null
          ? null
          : DateTime.parse(json['startTime'] as String),
      endTime: json['endTime'] == null
          ? null
          : DateTime.parse(json['endTime'] as String),
      teamOneScore: json['teamOneScore'] as int,
      teamTwoScore: json['teamTwoScore'] as int,
      matchStarted: json['matchStarted'] as bool,
      matchEnded: json['matchEnded'] as bool,
      matchPaused: json['matchPaused'] as bool,
    );

Map<String, dynamic> _$CreateDoubleLeagueMatchesResponseToJson(
        CreateDoubleLeagueMatchesResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'teamOneId': instance.teamOneId,
      'teamTwoId': instance.teamTwoId,
      'leagueId': instance.leagueId,
      'startTime': instance.startTime?.toIso8601String(),
      'endTime': instance.endTime?.toIso8601String(),
      'teamOneScore': instance.teamOneScore,
      'teamTwoScore': instance.teamTwoScore,
      'matchStarted': instance.matchStarted,
      'matchEnded': instance.matchEnded,
      'matchPaused': instance.matchPaused,
    };
