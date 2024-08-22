// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'freehand_goal_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FreehandGoalModel _$FreehandGoalModelFromJson(Map<String, dynamic> json) =>
    FreehandGoalModel(
      id: (json['id'] as num).toInt(),
      timeOfGoal: DateTime.parse(json['timeOfGoal'] as String),
      matchId: (json['matchId'] as num).toInt(),
      scoredByUserId: (json['scoredByUserId'] as num).toInt(),
      oponentId: (json['oponentId'] as num).toInt(),
      scoredByScore: (json['scoredByScore'] as num).toInt(),
      oponentScore: (json['oponentScore'] as num).toInt(),
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
