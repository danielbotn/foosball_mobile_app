// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'historyModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HistoryModel _$HistoryModelFromJson(Map<String, dynamic> json) => HistoryModel(
      typeOfMatch: (json['typeOfMatch'] as num).toInt(),
      typeOfMatchName: json['typeOfMatchName'] as String,
      userId: (json['userId'] as num).toInt(),
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
    );

Map<String, dynamic> _$HistoryModelToJson(HistoryModel instance) =>
    <String, dynamic>{
      'typeOfMatch': instance.typeOfMatch,
      'typeOfMatchName': instance.typeOfMatchName,
      'userId': instance.userId,
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
    };
