// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'double_league_goal_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DoubleLeagueGoalModel _$DoubleLeagueGoalModelFromJson(
        Map<String, dynamic> json) =>
    DoubleLeagueGoalModel(
      id: (json['id'] as num).toInt(),
      timeOfGoal: DateTime.parse(json['timeOfGoal'] as String),
      scoredByTeamId: (json['scoredByTeamId'] as num).toInt(),
      opponentTeamId: (json['opponentTeamId'] as num).toInt(),
      scorerTeamScore: (json['scorerTeamScore'] as num).toInt(),
      opponentTeamScore: (json['opponentTeamScore'] as num).toInt(),
      winnerGoal: json['winnerGoal'] as bool,
      userScorerId: (json['userScorerId'] as num).toInt(),
      doubleLeagueTeamId: (json['doubleLeagueTeamId'] as num).toInt(),
      scorerFirstName: json['scorerFirstName'] as String,
      scorerLastName: json['scorerLastName'] as String,
      scorerPhotoUrl: json['scorerPhotoUrl'] as String,
      goalTimeStopWatch: json['goalTimeStopWatch'] as String,
    );

Map<String, dynamic> _$DoubleLeagueGoalModelToJson(
        DoubleLeagueGoalModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'timeOfGoal': instance.timeOfGoal.toIso8601String(),
      'scoredByTeamId': instance.scoredByTeamId,
      'opponentTeamId': instance.opponentTeamId,
      'scorerTeamScore': instance.scorerTeamScore,
      'opponentTeamScore': instance.opponentTeamScore,
      'winnerGoal': instance.winnerGoal,
      'userScorerId': instance.userScorerId,
      'doubleLeagueTeamId': instance.doubleLeagueTeamId,
      'scorerFirstName': instance.scorerFirstName,
      'scorerLastName': instance.scorerLastName,
      'scorerPhotoUrl': instance.scorerPhotoUrl,
      'goalTimeStopWatch': instance.goalTimeStopWatch,
    };
