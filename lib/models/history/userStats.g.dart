// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'userStats.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserStats _$UserStatsFromJson(Map<String, dynamic> json) => UserStats(
      userId: (json['userId'] as num).toInt(),
      totalMatches: (json['totalMatches'] as num).toInt(),
      totalFreehandMatches: (json['totalFreehandMatches'] as num).toInt(),
      totalDoubleFreehandMatches:
          (json['totalDoubleFreehandMatches'] as num).toInt(),
      totalSingleLeagueMatches:
          (json['totalSingleLeagueMatches'] as num).toInt(),
      totalDoubleLeagueMatches:
          (json['totalDoubleLeagueMatches'] as num).toInt(),
      totalMatchesWon: (json['totalMatchesWon'] as num).toInt(),
      totalMatchesLost: (json['totalMatchesLost'] as num).toInt(),
      totalGoalsScored: (json['totalGoalsScored'] as num).toInt(),
      totalGoalsReceived: (json['totalGoalsReceived'] as num).toInt(),
    );

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
