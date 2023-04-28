// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'single_league_match_update_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SingleLeagueMatchUpdateModel _$SingleLeagueMatchUpdateModelFromJson(
        Map<String, dynamic> json) =>
    SingleLeagueMatchUpdateModel(
      startTime: json['startTime'] == null
          ? null
          : DateTime.parse(json['startTime'] as String),
      endTime: json['endTime'] == null
          ? null
          : DateTime.parse(json['endTime'] as String),
      playerOneScore: json['playerOneScore'] as int?,
      playerTwoScore: json['playerTwoScore'] as int?,
      matchStarted: json['matchStarted'] as bool?,
      matchEnded: json['matchEnded'] as bool?,
      matchPaused: json['matchPaused'] as bool?,
    );

Map<String, dynamic> _$SingleLeagueMatchUpdateModelToJson(
        SingleLeagueMatchUpdateModel instance) =>
    <String, dynamic>{
      'startTime': instance.startTime?.toIso8601String(),
      'endTime': instance.endTime?.toIso8601String(),
      'playerOneScore': instance.playerOneScore,
      'playerTwoScore': instance.playerTwoScore,
      'matchStarted': instance.matchStarted,
      'matchEnded': instance.matchEnded,
      'matchPaused': instance.matchPaused,
    };
