// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'double-league-standings-model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DoubleLeagueStandingsModel _$DoubleLeagueStandingsModelFromJson(
        Map<String, dynamic> json) =>
    DoubleLeagueStandingsModel(
      teamID: json['teamID'] as int,
      leagueId: json['leagueId'] as int,
      totalMatchesWon: json['totalMatchesWon'] as int,
      totalMatchesLost: json['totalMatchesLost'] as int,
      totalGoalsScored: json['totalGoalsScored'] as int,
      totalGoalsRecieved: json['totalGoalsRecieved'] as int,
      positionInLeague: json['positionInLeague'] as int,
      matchesPlayed: json['matchesPlayed'] as int,
      points: json['points'] as int,
      teamName: json['teamName'] as String,
      teamMembers: (json['teamMembers'] as List<dynamic>)
          .map((e) => TeamMemberModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$DoubleLeagueStandingsModelToJson(
        DoubleLeagueStandingsModel instance) =>
    <String, dynamic>{
      'teamID': instance.teamID,
      'leagueId': instance.leagueId,
      'totalMatchesWon': instance.totalMatchesWon,
      'totalMatchesLost': instance.totalMatchesLost,
      'totalGoalsScored': instance.totalGoalsScored,
      'totalGoalsRecieved': instance.totalGoalsRecieved,
      'positionInLeague': instance.positionInLeague,
      'matchesPlayed': instance.matchesPlayed,
      'points': instance.points,
      'teamName': instance.teamName,
      'teamMembers': instance.teamMembers,
    };
