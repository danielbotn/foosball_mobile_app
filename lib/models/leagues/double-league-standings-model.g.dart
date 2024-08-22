// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'double-league-standings-model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DoubleLeagueStandingsModel _$DoubleLeagueStandingsModelFromJson(
        Map<String, dynamic> json) =>
    DoubleLeagueStandingsModel(
      teamID: (json['teamID'] as num).toInt(),
      leagueId: (json['leagueId'] as num).toInt(),
      totalMatchesWon: (json['totalMatchesWon'] as num).toInt(),
      totalMatchesLost: (json['totalMatchesLost'] as num).toInt(),
      totalGoalsScored: (json['totalGoalsScored'] as num).toInt(),
      totalGoalsRecieved: (json['totalGoalsRecieved'] as num).toInt(),
      positionInLeague: (json['positionInLeague'] as num).toInt(),
      matchesPlayed: (json['matchesPlayed'] as num).toInt(),
      points: (json['points'] as num).toInt(),
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
