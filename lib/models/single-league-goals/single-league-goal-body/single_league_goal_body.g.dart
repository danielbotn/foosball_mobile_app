// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'single_league_goal_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SingleLeagueGoalBody _$SingleLeagueGoalBodyFromJson(
        Map<String, dynamic> json) =>
    SingleLeagueGoalBody(
      matchId: json['matchId'] as int,
      scoredByUserId: json['scoredByUserId'] as int,
      opponentId: json['opponentId'] as int,
      scorerScore: json['scorerScore'] as int,
      opponentScore: json['opponentScore'] as int,
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
