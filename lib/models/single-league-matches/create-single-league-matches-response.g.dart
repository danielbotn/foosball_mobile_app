// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create-single-league-matches-response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateSingleLeagueMatchesResponse _$CreateSingleLeagueMatchesResponseFromJson(
        Map<String, dynamic> json) =>
    CreateSingleLeagueMatchesResponse(
      id: (json['id'] as num).toInt(),
      playerOne: (json['playerOne'] as num).toInt(),
      playerTwo: (json['playerTwo'] as num).toInt(),
      leagueId: (json['leagueId'] as num).toInt(),
      startTime: json['startTime'] == null
          ? null
          : DateTime.parse(json['startTime'] as String),
      endTime: json['endTime'] == null
          ? null
          : DateTime.parse(json['endTime'] as String),
      playerOneScore: (json['playerOneScore'] as num).toInt(),
      playerTwoScore: (json['playerTwoScore'] as num).toInt(),
      matchStarted: json['matchStarted'] as bool,
      matchEnded: json['matchEnded'] as bool,
      matchPaused: json['matchPaused'] as bool,
    );

Map<String, dynamic> _$CreateSingleLeagueMatchesResponseToJson(
        CreateSingleLeagueMatchesResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'playerOne': instance.playerOne,
      'playerTwo': instance.playerTwo,
      'leagueId': instance.leagueId,
      'startTime': instance.startTime?.toIso8601String(),
      'endTime': instance.endTime?.toIso8601String(),
      'playerOneScore': instance.playerOneScore,
      'playerTwoScore': instance.playerTwoScore,
      'matchStarted': instance.matchStarted,
      'matchEnded': instance.matchEnded,
      'matchPaused': instance.matchPaused,
    };
