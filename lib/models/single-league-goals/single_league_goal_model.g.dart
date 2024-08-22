// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'single_league_goal_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SingleLeagueGoalModel _$SingleLeagueGoalModelFromJson(
        Map<String, dynamic> json) =>
    SingleLeagueGoalModel(
      id: (json['id'] as num).toInt(),
      timeOfGoal: DateTime.parse(json['timeOfGoal'] as String),
      matchId: (json['matchId'] as num).toInt(),
      scoredByUserId: (json['scoredByUserId'] as num).toInt(),
      scoredByUserFirstName: json['scoredByUserFirstName'] as String,
      scoredByUserLastName: json['scoredByUserLastName'] as String,
      scoredByUserPhotoUrl: json['scoredByUserPhotoUrl'] as String,
      opponentId: (json['opponentId'] as num).toInt(),
      opponentFirstName: json['opponentFirstName'] as String,
      opponentLastName: json['opponentLastName'] as String,
      opponentPhotoUrl: json['opponentPhotoUrl'] as String,
      scorerScore: (json['scorerScore'] as num).toInt(),
      opponentScore: (json['opponentScore'] as num).toInt(),
      winnerGoal: json['winnerGoal'] as bool,
      goalTimeStopWatch: json['goalTimeStopWatch'] as String,
    );

Map<String, dynamic> _$SingleLeagueGoalModelToJson(
        SingleLeagueGoalModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'timeOfGoal': instance.timeOfGoal.toIso8601String(),
      'matchId': instance.matchId,
      'scoredByUserId': instance.scoredByUserId,
      'scoredByUserFirstName': instance.scoredByUserFirstName,
      'scoredByUserLastName': instance.scoredByUserLastName,
      'scoredByUserPhotoUrl': instance.scoredByUserPhotoUrl,
      'opponentId': instance.opponentId,
      'opponentFirstName': instance.opponentFirstName,
      'opponentLastName': instance.opponentLastName,
      'opponentPhotoUrl': instance.opponentPhotoUrl,
      'scorerScore': instance.scorerScore,
      'opponentScore': instance.opponentScore,
      'winnerGoal': instance.winnerGoal,
      'goalTimeStopWatch': instance.goalTimeStopWatch,
    };
