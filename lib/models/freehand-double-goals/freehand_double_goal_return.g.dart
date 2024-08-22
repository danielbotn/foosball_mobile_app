// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'freehand_double_goal_return.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FreehandDoubleGoalReturn _$FreehandDoubleGoalReturnFromJson(
        Map<String, dynamic> json) =>
    FreehandDoubleGoalReturn(
      doubleMatchId: (json['doubleMatchId'] as num).toInt(),
      scoredByUserId: (json['scoredByUserId'] as num).toInt(),
      scorerTeamScore: (json['scorerTeamScore'] as num).toInt(),
      opponentTeamScore: (json['opponentTeamScore'] as num).toInt(),
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
