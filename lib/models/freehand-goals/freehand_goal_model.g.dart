// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'freehand_goal_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FreehandGoalModel _$FreehandGoalModelFromJson(Map<String, dynamic> json) =>
    FreehandGoalModel(
      id: json['id'] as int,
      timeOfGoal: DateTime.parse(json['timeOfGoal'] as String),
      matchId: json['matchId'] as int,
      scoredByUserId: json['scoredByUserId'] as int,
      oponentId: json['oponentId'] as int,
      scoredByScore: json['scoredByScore'] as int,
      oponentScore: json['oponentScore'] as int,
      winnerGoal: json['winnerGoal'] as bool,
    );

Map<String, dynamic> _$FreehandGoalModelToJson(FreehandGoalModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'timeOfGoal': instance.timeOfGoal.toIso8601String(),
      'matchId': instance.matchId,
      'scoredByUserId': instance.scoredByUserId,
      'oponentId': instance.oponentId,
      'scoredByScore': instance.scoredByScore,
      'oponentScore': instance.oponentScore,
      'winnerGoal': instance.winnerGoal,
    };
