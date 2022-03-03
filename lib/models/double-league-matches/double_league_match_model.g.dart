// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'double_league_match_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DoubleLeagueMatchModel _$DoubleLeagueMatchModelFromJson(
    Map<String, dynamic> json) {
  return DoubleLeagueMatchModel(
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
    totalPlayingTime: json['totalPlayingTime'] as String?,
    teamOne: (json['teamOne'] as List<dynamic>)
        .map((e) => TeamModel.fromJson(e as Map<String, dynamic>))
        .toList(),
    teamTwo: (json['teamTwo'] as List<dynamic>)
        .map((e) => TeamModel.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

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
