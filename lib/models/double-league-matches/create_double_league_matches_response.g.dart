// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_double_league_matches_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateDoubleLeagueMatchesResponse _$CreateDoubleLeagueMatchesResponseFromJson(
        Map<String, dynamic> json) =>
    CreateDoubleLeagueMatchesResponse(
      id: (json['id'] as num).toInt(),
      teamOneId: (json['teamOneId'] as num).toInt(),
      teamTwoId: (json['teamTwoId'] as num).toInt(),
      leagueId: (json['leagueId'] as num).toInt(),
      startTime: json['startTime'] == null
          ? null
          : DateTime.parse(json['startTime'] as String),
      endTime: json['endTime'] == null
          ? null
          : DateTime.parse(json['endTime'] as String),
      teamOneScore: (json['teamOneScore'] as num).toInt(),
      teamTwoScore: (json['teamTwoScore'] as num).toInt(),
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
