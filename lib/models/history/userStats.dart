import 'package:json_annotation/json_annotation.dart';

part 'userStats.g.dart';

@JsonSerializable()
class UserStats {
    final int userId;
    final int totalMatches;
    final int totalFreehandMatches;
    final int totalDoubleFreehandMatches;
    final int totalSingleLeagueMatches;
    final int totalDoubleLeagueMatches;
    final int totalMatchesWon;
    final int totalMatchesLost;
    final int totalGoalsScored;
    final int totalGoalsReceived;

    UserStats(
      {
        required this.userId,
        required this.totalMatches,
        required this.totalFreehandMatches,
        required this.totalDoubleFreehandMatches,
        required this.totalSingleLeagueMatches,
        required this.totalDoubleLeagueMatches,
        required this.totalMatchesWon,
        required this.totalMatchesLost,
        required this.totalGoalsScored,
        required this.totalGoalsReceived,
      }
    );
  
   factory UserStats.fromJson(Map<String, dynamic> item) =>
      _$UserStatsFromJson(item);

  Map<String, dynamic> toJson(item) => _$UserStatsToJson(item);
}