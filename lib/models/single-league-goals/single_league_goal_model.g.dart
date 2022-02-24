// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'single_league_goal_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SingleLeagueGoalModel _$SingleLeagueGoalModelFromJson(
    Map<String, dynamic> json) {
  return SingleLeagueGoalModel(
    id: json['id'] as int,
    timeOfGoal: DateTime.parse(json['timeOfGoal'] as String),
    matchId: json['matchId'] as int,
    scoredByUserId: json['scoredByUserId'] as int,
    opponentId: json['opponentId'] as int,
    scorerScore: json['scorerScore'] as int,
    opponentScore: json['opponentScore'] as int,
    winnerGoal: json['winnerGoal'] as bool,
  );
}

Map<String, dynamic> _$SingleLeagueGoalModelToJson(
        SingleLeagueGoalModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'timeOfGoal': instance.timeOfGoal.toIso8601String(),
      'matchId': instance.matchId,
      'scoredByUserId': instance.scoredByUserId,
      'opponentId': instance.opponentId,
      'scorerScore': instance.scorerScore,
      'opponentScore': instance.opponentScore,
      'winnerGoal': instance.winnerGoal,
    };
