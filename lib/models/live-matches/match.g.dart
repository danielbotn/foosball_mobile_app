// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'match.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Match _$MatchFromJson(Map<String, dynamic> json) => Match(
      typeOfMatch: $enumDecode(_$ETypeOfMatchEnumMap, json['typeOfMatch']),
      typeOfMatchName: json['typeOfMatchName'] as String,
      userId: (json['userId'] as num).toInt(),
      userFirstName: json['userFirstName'] as String,
      userLastName: json['userLastName'] as String,
      userPhotoUrl: json['userPhotoUrl'] as String,
      teamMateId: (json['teamMateId'] as num?)?.toInt(),
      teamMateFirstName: json['teamMateFirstName'] as String?,
      teamMateLastName: json['teamMateLastName'] as String?,
      teamMatePhotoUrl: json['teamMatePhotoUrl'] as String?,
      matchId: (json['matchId'] as num).toInt(),
      opponentId: (json['opponentId'] as num).toInt(),
      opponentTwoId: (json['opponentTwoId'] as num?)?.toInt(),
      opponentOneFirstName: json['opponentOneFirstName'] as String,
      opponentOneLastName: json['opponentOneLastName'] as String,
      opponentOnePhotoUrl: json['opponentOnePhotoUrl'] as String,
      opponentTwoFirstName: json['opponentTwoFirstName'] as String?,
      opponentTwoLastName: json['opponentTwoLastName'] as String?,
      opponentTwoPhotoUrl: json['opponentTwoPhotoUrl'] as String?,
      userScore: (json['userScore'] as num).toInt(),
      opponentUserOrTeamScore: (json['opponentUserOrTeamScore'] as num).toInt(),
      dateOfGame: DateTime.parse(json['dateOfGame'] as String),
      leagueId: (json['leagueId'] as num?)?.toInt(),
      goalScorer: json['goalScorer'] == null
          ? null
          : UserResponse.fromJson(json['goalScorer'] as Map<String, dynamic>),
      lastGoal: json['lastGoal'] == null
          ? null
          : GoalInfo.fromJson(json['lastGoal'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$MatchToJson(Match instance) => <String, dynamic>{
      'typeOfMatch': _$ETypeOfMatchEnumMap[instance.typeOfMatch]!,
      'typeOfMatchName': instance.typeOfMatchName,
      'userId': instance.userId,
      'userFirstName': instance.userFirstName,
      'userLastName': instance.userLastName,
      'userPhotoUrl': instance.userPhotoUrl,
      'teamMateId': instance.teamMateId,
      'teamMateFirstName': instance.teamMateFirstName,
      'teamMateLastName': instance.teamMateLastName,
      'teamMatePhotoUrl': instance.teamMatePhotoUrl,
      'matchId': instance.matchId,
      'opponentId': instance.opponentId,
      'opponentTwoId': instance.opponentTwoId,
      'opponentOneFirstName': instance.opponentOneFirstName,
      'opponentOneLastName': instance.opponentOneLastName,
      'opponentOnePhotoUrl': instance.opponentOnePhotoUrl,
      'opponentTwoFirstName': instance.opponentTwoFirstName,
      'opponentTwoLastName': instance.opponentTwoLastName,
      'opponentTwoPhotoUrl': instance.opponentTwoPhotoUrl,
      'userScore': instance.userScore,
      'opponentUserOrTeamScore': instance.opponentUserOrTeamScore,
      'dateOfGame': instance.dateOfGame.toIso8601String(),
      'leagueId': instance.leagueId,
      'goalScorer': instance.goalScorer,
      'lastGoal': instance.lastGoal,
    };

const _$ETypeOfMatchEnumMap = {
  ETypeOfMatch.freehandMatch: 'freehandMatch',
  ETypeOfMatch.doubleFreehandMatch: 'doubleFreehandMatch',
  ETypeOfMatch.singleLeagueMatch: 'singleLeagueMatch',
  ETypeOfMatch.doubleLeagueMatch: 'doubleLeagueMatch',
};
