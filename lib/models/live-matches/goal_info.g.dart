// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'goal_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PlayerInfo _$PlayerInfoFromJson(Map<String, dynamic> json) => PlayerInfo(
      id: (json['id'] as num).toInt(),
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      photoUrl: json['photoUrl'] as String,
    );

Map<String, dynamic> _$PlayerInfoToJson(PlayerInfo instance) =>
    <String, dynamic>{
      'id': instance.id,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'photoUrl': instance.photoUrl,
    };

GoalInfo _$GoalInfoFromJson(Map<String, dynamic> json) => GoalInfo(
      scoredByUserId: (json['scoredByUserId'] as num).toInt(),
      scorerTeamScore: (json['scorerTeamScore'] as num).toInt(),
      opponentTeamScore: (json['opponentTeamScore'] as num).toInt(),
      timeOfGoal: DateTime.parse(json['timeOfGoal'] as String),
      winnerGoal: json['winnerGoal'] as bool,
      scorer: PlayerInfo.fromJson(json['scorer'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$GoalInfoToJson(GoalInfo instance) => <String, dynamic>{
      'scoredByUserId': instance.scoredByUserId,
      'scorerTeamScore': instance.scorerTeamScore,
      'opponentTeamScore': instance.opponentTeamScore,
      'timeOfGoal': instance.timeOfGoal.toIso8601String(),
      'winnerGoal': instance.winnerGoal,
      'scorer': instance.scorer,
    };
