// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'single-league-standings-model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SingleLeagueStandingsModel _$SingleLeagueStandingsModelFromJson(
        Map<String, dynamic> json) =>
    SingleLeagueStandingsModel(
      userId: json['userId'] as int,
      leagueId: json['leagueId'] as int,
      totalMatchesWon: json['totalMatchesWon'] as int,
      totalMatchesLost: json['totalMatchesLost'] as int,
      totalGoalsScored: json['totalGoalsScored'] as int,
      totalGoalsRecieved: json['totalGoalsRecieved'] as int,
      positionInLeague: json['positionInLeague'] as int,
      points: json['points'] as int,
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
