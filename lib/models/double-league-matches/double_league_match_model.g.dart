// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'double_league_match_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DoubleLeagueMatchModel _$DoubleLeagueMatchModelFromJson(
        Map<String, dynamic> json) =>
    DoubleLeagueMatchModel(
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
      totalPlayingTime: json['totalPlayingTime'] as String?,
      teamOne: (json['teamOne'] as List<dynamic>)
          .map((e) => TeamModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      teamTwo: (json['teamTwo'] as List<dynamic>)
          .map((e) => TeamModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$DoubleLeagueMatchModelToJson(
        DoubleLeagueMatchModel instance) =>
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
      'totalPlayingTime': instance.totalPlayingTime,
      'teamOne': instance.teamOne.map((e) => e.toJson()).toList(),
      'teamTwo': instance.teamTwo.map((e) => e.toJson()).toList(),
    };
