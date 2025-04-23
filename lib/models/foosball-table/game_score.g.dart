// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game_score.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GameScore _$GameScoreFromJson(Map<String, dynamic> json) => GameScore(
      teamName: json['teamName'] as String,
      teamScore: (json['teamScore'] as num).toInt(),
      opponentTeamScore: (json['opponentTeamScore'] as num).toInt(),
      timeOfGoal: json['timeOfGoal'] as String,
    );

Map<String, dynamic> _$GameScoreToJson(GameScore instance) => <String, dynamic>{
      'teamName': instance.teamName,
      'teamScore': instance.teamScore,
      'opponentTeamScore': instance.opponentTeamScore,
      'timeOfGoal': instance.timeOfGoal,
    };
