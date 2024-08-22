// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'single-league-standings-model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SingleLeagueStandingsModel _$SingleLeagueStandingsModelFromJson(
        Map<String, dynamic> json) =>
    SingleLeagueStandingsModel(
      userId: (json['userId'] as num).toInt(),
      leagueId: (json['leagueId'] as num).toInt(),
      totalMatchesWon: (json['totalMatchesWon'] as num).toInt(),
      totalMatchesLost: (json['totalMatchesLost'] as num).toInt(),
      totalGoalsScored: (json['totalGoalsScored'] as num).toInt(),
      totalGoalsRecieved: (json['totalGoalsRecieved'] as num).toInt(),
      positionInLeague: (json['positionInLeague'] as num).toInt(),
      points: (json['points'] as num).toInt(),
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      email: json['email'] as String,
    );

Map<String, dynamic> _$SingleLeagueStandingsModelToJson(
        SingleLeagueStandingsModel instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'leagueId': instance.leagueId,
      'totalMatchesWon': instance.totalMatchesWon,
      'totalMatchesLost': instance.totalMatchesLost,
      'totalGoalsScored': instance.totalGoalsScored,
      'totalGoalsRecieved': instance.totalGoalsRecieved,
      'positionInLeague': instance.positionInLeague,
      'points': instance.points,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'email': instance.email,
    };
