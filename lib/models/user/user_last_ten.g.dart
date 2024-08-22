// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_last_ten.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserLastTen _$UserLastTenFromJson(Map<String, dynamic> json) => UserLastTen(
      typeOfMatch: (json['typeOfMatch'] as num).toInt(),
      typeOfMatchName: json['typeOfMatchName'] as String,
      userId: (json['userId'] as num).toInt(),
      teamMateId: (json['teamMateId'] as num?)?.toInt(),
      matchId: (json['matchId'] as num).toInt(),
      opponentId: (json['opponentId'] as num).toInt(),
      opponentTwoId: (json['opponentTwoId'] as num?)?.toInt(),
      opponentOneFirstName: json['opponentOneFirstName'] as String,
      opponentOneLastName: json['opponentOneLastName'] as String,
      opponentTwoFirstName: json['opponentTwoFirstName'] as String?,
      opponentTwoLastName: json['opponentTwoLastName'] as String?,
      userScore: (json['userScore'] as num).toInt(),
      opponentUserOrTeamScore: (json['opponentUserOrTeamScore'] as num).toInt(),
      dateOfGame: DateTime.parse(json['dateOfGame'] as String),
      leagueId: (json['leagueId'] as num?)?.toInt(),
    );

Map<String, dynamic> _$UserLastTenToJson(UserLastTen instance) =>
    <String, dynamic>{
      'typeOfMatch': instance.typeOfMatch,
      'typeOfMatchName': instance.typeOfMatchName,
      'userId': instance.userId,
      'teamMateId': instance.teamMateId,
      'matchId': instance.matchId,
      'opponentId': instance.opponentId,
      'opponentTwoId': instance.opponentTwoId,
      'opponentOneFirstName': instance.opponentOneFirstName,
      'opponentOneLastName': instance.opponentOneLastName,
      'opponentTwoFirstName': instance.opponentTwoFirstName,
      'opponentTwoLastName': instance.opponentTwoLastName,
      'userScore': instance.userScore,
      'opponentUserOrTeamScore': instance.opponentUserOrTeamScore,
      'dateOfGame': instance.dateOfGame.toIso8601String(),
      'leagueId': instance.leagueId,
    };
