// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create-single-league-matches-response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateSingleLeagueMatchesResponse _$CreateSingleLeagueMatchesResponseFromJson(
        Map<String, dynamic> json) =>
    CreateSingleLeagueMatchesResponse(
      id: json['id'] as int,
      playerOne: json['playerOne'] as int,
      playerTwo: json['playerTwo'] as int,
      leagueId: json['leagueId'] as int,
      startTime: json['startTime'] == null
          ? null
          : DateTime.parse(json['startTime'] as String),
      endTime: json['endTime'] == null
          ? null
          : DateTime.parse(json['endTime'] as String),
      playerOneScore: json['playerOneScore'] as int,
      playerTwoScore: json['playerTwoScore'] as int,
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
