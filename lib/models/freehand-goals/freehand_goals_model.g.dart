// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'freehand_goals_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FreehandGoalsModel _$FreehandGoalsModelFromJson(Map<String, dynamic> json) =>
    FreehandGoalsModel(
      id: json['id'] as int,
      timeOfGoal: DateTime.parse(json['timeOfGoal'] as String),
      goalTimeStopWatch: json['goalTimeStopWatch'] as String,
      matchId: json['matchId'] as int,
      scoredByUserId: json['scoredByUserId'] as int,
      scoredByUserFirstName: json['scoredByUserFirstName'] as String,
      scoredByUserLastName: json['scoredByUserLastName'] as String,
      scoredByUserPhotoUrl: json['scoredByUserPhotoUrl'] as String,
      oponentId: json['oponentId'] as int,
      oponentFirstName: json['oponentFirstName'] as String,
      oponentLastName: json['oponentLastName'] as String,
      oponentPhotoUrl: json['oponentPhotoUrl'] as String,
      scoredByScore: json['scoredByScore'] as int,
      oponentScore: json['oponentScore'] as int,
      winnerGoal: json['winnerGoal'] as bool,
    );

Map<String, dynamic> _$FreehandGoalsModelToJson(FreehandGoalsModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'timeOfGoal': instance.timeOfGoal.toIso8601String(),
      'goalTimeStopWatch': instance.goalTimeStopWatch,
      'matchId': instance.matchId,
      'scoredByUserId': instance.scoredByUserId,
      'scoredByUserFirstName': instance.scoredByUserFirstName,
      'scoredByUserLastName': instance.scoredByUserLastName,
      'scoredByUserPhotoUrl': instance.scoredByUserPhotoUrl,
      'oponentId': instance.oponentId,
      'oponentFirstName': instance.oponentFirstName,
      'oponentLastName': instance.oponentLastName,
      'oponentPhotoUrl': instance.oponentPhotoUrl,
      'scoredByScore': instance.scoredByScore,
      'oponentScore': instance.oponentScore,
      'winnerGoal': instance.winnerGoal,
    };
