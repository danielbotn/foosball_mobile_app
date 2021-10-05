import 'package:json_annotation/json_annotation.dart';

part 'user_stats_response.g.dart';

@JsonSerializable()
class UserStatsResponse {
  final int userId;
  final int totalMatches;
  final int totalMatchesWon;
  final int totalMatchesLost;
  final int totalGoalsScored;
  final int totalGoalsReceived;

  UserStatsResponse({required this.userId, required this.totalMatches, required this.totalMatchesWon, required this.totalMatchesLost, required this.totalGoalsScored, required this.totalGoalsReceived});

  factory UserStatsResponse.fromJson(Map<String, dynamic> item) => _$UserStatsResponseFromJson(item);

  Map<String, dynamic> toJson(item) => _$UserStatsResponseToJson(item);
}