// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_stats_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserStatsResponse _$UserStatsResponseFromJson(Map<String, dynamic> json) =>
    UserStatsResponse(
      userId: json['userId'] as int,
      totalMatches: json['totalMatches'] as int,
      totalMatchesWon: json['totalMatchesWon'] as int,
      totalMatchesLost: json['totalMatchesLost'] as int,
      totalGoalsScored: json['totalGoalsScored'] as int,
      totalGoalsReceived: json['totalGoalsReceived'] as int,
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
