// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_stats_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserStatsResponse _$UserStatsResponseFromJson(Map<String, dynamic> json) =>
    UserStatsResponse(
      userId: (json['userId'] as num).toInt(),
      totalMatches: (json['totalMatches'] as num).toInt(),
      totalMatchesWon: (json['totalMatchesWon'] as num).toInt(),
      totalMatchesLost: (json['totalMatchesLost'] as num).toInt(),
      totalGoalsScored: (json['totalGoalsScored'] as num).toInt(),
      totalGoalsReceived: (json['totalGoalsReceived'] as num).toInt(),
    );

Map<String, dynamic> _$UserStatsResponseToJson(UserStatsResponse instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'totalMatches': instance.totalMatches,
      'totalMatchesWon': instance.totalMatchesWon,
      'totalMatchesLost': instance.totalMatchesLost,
      'totalGoalsScored': instance.totalGoalsScored,
      'totalGoalsReceived': instance.totalGoalsReceived,
    };
