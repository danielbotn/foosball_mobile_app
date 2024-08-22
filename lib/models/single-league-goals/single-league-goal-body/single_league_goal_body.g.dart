// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'single_league_goal_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SingleLeagueGoalBody _$SingleLeagueGoalBodyFromJson(
        Map<String, dynamic> json) =>
    SingleLeagueGoalBody(
      matchId: (json['matchId'] as num).toInt(),
      scoredByUserId: (json['scoredByUserId'] as num).toInt(),
      opponentId: (json['opponentId'] as num).toInt(),
      scorerScore: (json['scorerScore'] as num).toInt(),
      opponentScore: (json['opponentScore'] as num).toInt(),
      winnerGoal: json['winnerGoal'] as bool,
    );

Map<String, dynamic> _$SingleLeagueGoalBodyToJson(
        SingleLeagueGoalBody instance) =>
    <String, dynamic>{
      'matchId': instance.matchId,
      'scoredByUserId': instance.scoredByUserId,
      'opponentId': instance.opponentId,
      'scorerScore': instance.scorerScore,
      'opponentScore': instance.opponentScore,
      'winnerGoal': instance.winnerGoal,
    };
