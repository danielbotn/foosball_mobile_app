// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'single_league_goal_create_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SingleLeagueGoalCreateResponse _$SingleLeagueGoalCreateResponseFromJson(
        Map<String, dynamic> json) =>
    SingleLeagueGoalCreateResponse(
      id: (json['id'] as num).toInt(),
      timeOfGoal: DateTime.parse(json['timeOfGoal'] as String),
      matchId: (json['matchId'] as num).toInt(),
      scoredByUserId: (json['scoredByUserId'] as num).toInt(),
      opponentId: (json['opponentId'] as num).toInt(),
      scorerScore: (json['scorerScore'] as num).toInt(),
      opponentScore: (json['opponentScore'] as num).toInt(),
      winnerGoal: json['winnerGoal'] as bool,
    );

Map<String, dynamic> _$SingleLeagueGoalCreateResponseToJson(
        SingleLeagueGoalCreateResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'timeOfGoal': instance.timeOfGoal.toIso8601String(),
      'matchId': instance.matchId,
      'scoredByUserId': instance.scoredByUserId,
      'opponentId': instance.opponentId,
      'scorerScore': instance.scorerScore,
      'opponentScore': instance.opponentScore,
      'winnerGoal': instance.winnerGoal,
    };
