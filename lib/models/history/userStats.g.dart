// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'userStats.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserStats _$UserStatsFromJson(Map<String, dynamic> json) {
  return UserStats(
    userId: json['userId'] as int,
    totalMatches: json['totalMatches'] as int,
    totalFreehandMatches: json['totalFreehandMatches'] as int,
    totalDoubleFreehandMatches: json['totalDoubleFreehandMatches'] as int,
    totalSingleLeagueMatches: json['totalSingleLeagueMatches'] as int,
    totalDoubleLeagueMatches: json['totalDoubleLeagueMatches'] as int,
    totalMatchesWon: json['totalMatchesWon'] as int,
    totalMatchesLost: json['totalMatchesLost'] as int,
    totalGoalsScored: json['totalGoalsScored'] as int,
    totalGoalsReceived: json['totalGoalsReceived'] as int,
  );
}

Map<String, dynamic> _$UserStatsToJson(UserStats instance) => <String, dynamic>{
      'userId': instance.userId,
      'totalMatches': instance.totalMatches,
      'totalFreehandMatches': instance.totalFreehandMatches,
      'totalDoubleFreehandMatches': instance.totalDoubleFreehandMatches,
      'totalSingleLeagueMatches': instance.totalSingleLeagueMatches,
      'totalDoubleLeagueMatches': instance.totalDoubleLeagueMatches,
      'totalMatchesWon': instance.totalMatchesWon,
      'totalMatchesLost': instance.totalMatchesLost,
      'totalGoalsScored': instance.totalGoalsScored,
      'totalGoalsReceived': instance.totalGoalsReceived,
    };
