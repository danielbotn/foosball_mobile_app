// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'freehand_double_goal_return.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FreehandDoubleGoalReturn _$FreehandDoubleGoalReturnFromJson(
        Map<String, dynamic> json) =>
    FreehandDoubleGoalReturn(
      doubleMatchId: json['doubleMatchId'] as int,
      scoredByUserId: json['scoredByUserId'] as int,
      scorerTeamScore: json['scorerTeamScore'] as int,
      opponentTeamScore: json['opponentTeamScore'] as int,
      winnerGoal: json['winnerGoal'] as bool,
    );

Map<String, dynamic> _$FreehandDoubleGoalReturnToJson(
        FreehandDoubleGoalReturn instance) =>
    <String, dynamic>{
      'doubleMatchId': instance.doubleMatchId,
      'scoredByUserId': instance.scoredByUserId,
      'scorerTeamScore': instance.scorerTeamScore,
      'opponentTeamScore': instance.opponentTeamScore,
      'winnerGoal': instance.winnerGoal,
    };
