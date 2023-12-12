// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'double_league_goal_create_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DoubleLeagueGoalCreateResponse _$DoubleLeagueGoalCreateResponseFromJson(
        Map<String, dynamic> json) =>
    DoubleLeagueGoalCreateResponse(
      id: json['id'] as int,
      timeOfGoal: DateTime.parse(json['timeOfGoal'] as String),
      matchId: json['matchId'] as int,
      scoredByTeamId: json['scoredByTeamId'] as int,
      opponentTeamId: json['opponentTeamId'] as int,
      scorerTeamScore: json['scorerTeamScore'] as int,
      opponentTeamScore: json['opponentTeamScore'] as int,
      winnerGoal: json['winnerGoal'] as bool,
      userScorerId: json['userScorerId'] as int,
    );

Map<String, dynamic> _$DoubleLeagueGoalCreateResponseToJson(
        DoubleLeagueGoalCreateResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'timeOfGoal': instance.timeOfGoal.toIso8601String(),
      'matchId': instance.matchId,
      'scoredByTeamId': instance.scoredByTeamId,
      'opponentTeamId': instance.opponentTeamId,
      'scorerTeamScore': instance.scorerTeamScore,
      'opponentTeamScore': instance.opponentTeamScore,
      'winnerGoal': instance.winnerGoal,
      'userScorerId': instance.userScorerId,
    };
