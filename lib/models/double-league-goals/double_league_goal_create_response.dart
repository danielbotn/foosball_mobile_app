import 'package:json_annotation/json_annotation.dart';

part 'double_league_goal_create_response.g.dart';

@JsonSerializable()
class DoubleLeagueGoalCreateResponse {
  final int id;
  final DateTime timeOfGoal;
  final int matchId;
  final int scoredByTeamId;
  final int opponentTeamId;
  final int scorerTeamScore;
  final int opponentTeamScore;
  final bool winnerGoal;
  final int userScorerId;

  DoubleLeagueGoalCreateResponse({
    required this.id,
    required this.timeOfGoal,
    required this.matchId,
    required this.scoredByTeamId,
    required this.opponentTeamId,
    required this.scorerTeamScore,
    required this.opponentTeamScore,
    required this.winnerGoal,
    required this.userScorerId,
  });

  factory DoubleLeagueGoalCreateResponse.fromJson(Map<String, dynamic> item) =>
      _$DoubleLeagueGoalCreateResponseFromJson(item);

  Map<String, dynamic> toJson(item) =>
      _$DoubleLeagueGoalCreateResponseToJson(item);
}
