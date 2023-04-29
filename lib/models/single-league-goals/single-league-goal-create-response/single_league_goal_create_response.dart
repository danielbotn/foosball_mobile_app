import 'package:json_annotation/json_annotation.dart';

part 'single_league_goal_create_response.g.dart';

@JsonSerializable()
class SingleLeagueGoalCreateResponse {
  final int id;
  final DateTime timeOfGoal;
  final int matchId;
  final int scoredByUserId;
  final int opponentId;
  final int scorerScore;
  final int opponentScore;
  final bool winnerGoal;

  SingleLeagueGoalCreateResponse({
    required this.id,
    required this.timeOfGoal,
    required this.matchId,
    required this.scoredByUserId,
    required this.opponentId,
    required this.scorerScore,
    required this.opponentScore,
    required this.winnerGoal,
  });

  factory SingleLeagueGoalCreateResponse.fromJson(Map<String, dynamic> item) =>
      _$SingleLeagueGoalCreateResponseFromJson(item);

  Map<String, dynamic> toJson(item) =>
      _$SingleLeagueGoalCreateResponseToJson(item);
}
