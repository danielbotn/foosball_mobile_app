// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'freehand_double_goal_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FreehandDoubleGoalModel _$FreehandDoubleGoalModelFromJson(
        Map<String, dynamic> json) =>
    FreehandDoubleGoalModel(
      id: (json['id'] as num).toInt(),
      scoredByUserId: (json['scoredByUserId'] as num).toInt(),
      doubleMatchId: (json['doubleMatchId'] as num).toInt(),
      scorerTeamScore: (json['scorerTeamScore'] as num).toInt(),
      opponentTeamScore: (json['opponentTeamScore'] as num).toInt(),
      winnerGoal: json['winnerGoal'] as bool,
      timeOfGoal: DateTime.parse(json['timeOfGoal'] as String),
      goalTimeStopWatch: json['goalTimeStopWatch'] as String,
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      email: json['email'] as String,
      photoUrl: json['photoUrl'] as String,
    );

Map<String, dynamic> _$FreehandDoubleGoalModelToJson(
        FreehandDoubleGoalModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'scoredByUserId': instance.scoredByUserId,
      'doubleMatchId': instance.doubleMatchId,
      'scorerTeamScore': instance.scorerTeamScore,
      'opponentTeamScore': instance.opponentTeamScore,
      'winnerGoal': instance.winnerGoal,
      'timeOfGoal': instance.timeOfGoal.toIso8601String(),
      'goalTimeStopWatch': instance.goalTimeStopWatch,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'email': instance.email,
      'photoUrl': instance.photoUrl,
    };
