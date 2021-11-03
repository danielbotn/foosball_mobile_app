// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_last_ten.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserLastTen _$UserLastTenFromJson(Map<String, dynamic> json) {
  return UserLastTen(
    typeOfMatch: json['typeOfMatch'] as int,
    typeOfMatchName: json['typeOfMatchName'] as String,
    userId: json['userId'] as int,
    teamMateId: json['teamMateId'] as int?,
    matchId: json['matchId'] as int,
    opponentId: json['opponentId'] as int,
    opponentTwoId: json['opponentTwoId'] as int?,
    opponentOneFirstName: json['opponentOneFirstName'] as String,
    opponentOneLastName: json['opponentOneLastName'] as String,
    opponentTwoFirstName: json['opponentTwoFirstName'] as String?,
    opponentTwoLastName: json['opponentTwoLastName'] as String?,
    userScore: json['userScore'] as int,
    opponentUserOrTeamScore: json['opponentUserOrTeamScore'] as int,
    dateOfGame: DateTime.parse(json['dateOfGame'] as String),
  );
}

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
    };
