// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'double_league_match_update_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DoubleLeagueMatchUpdateModel _$DoubleLeagueMatchUpdateModelFromJson(
        Map<String, dynamic> json) =>
    DoubleLeagueMatchUpdateModel(
      startTime: json['startTime'] == null
          ? null
          : DateTime.parse(json['startTime'] as String),
      endTime: json['endTime'] == null
          ? null
          : DateTime.parse(json['endTime'] as String),
      teamOneScore: (json['teamOneScore'] as num?)?.toInt(),
      teamTwoScore: (json['teamTwoScore'] as num?)?.toInt(),
      matchStarted: json['matchStarted'] as bool?,
      matchEnded: json['matchEnded'] as bool?,
      matchPaused: json['matchPaused'] as bool?,
    );

Map<String, dynamic> _$DoubleLeagueMatchUpdateModelToJson(
        DoubleLeagueMatchUpdateModel instance) =>
    <String, dynamic>{
      'startTime': instance.startTime?.toIso8601String(),
      'endTime': instance.endTime?.toIso8601String(),
      'teamOneScore': instance.teamOneScore,
      'teamTwoScore': instance.teamTwoScore,
      'matchStarted': instance.matchStarted,
      'matchEnded': instance.matchEnded,
      'matchPaused': instance.matchPaused,
    };
