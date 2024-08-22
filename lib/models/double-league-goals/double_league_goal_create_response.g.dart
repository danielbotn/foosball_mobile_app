// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'double_league_goal_create_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DoubleLeagueGoalCreateResponse _$DoubleLeagueGoalCreateResponseFromJson(
        Map<String, dynamic> json) =>
    DoubleLeagueGoalCreateResponse(
      id: (json['id'] as num).toInt(),
      timeOfGoal: DateTime.parse(json['timeOfGoal'] as String),
      matchId: (json['matchId'] as num).toInt(),
      scoredByTeamId: (json['scoredByTeamId'] as num).toInt(),
      opponentTeamId: (json['opponentTeamId'] as num).toInt(),
      scorerTeamScore: (json['scorerTeamScore'] as num).toInt(),
      opponentTeamScore: (json['opponentTeamScore'] as num).toInt(),
      winnerGoal: json['winnerGoal'] as bool,
      userScorerId: (json['userScorerId'] as num).toInt(),
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
