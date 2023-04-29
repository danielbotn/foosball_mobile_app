import 'package:json_annotation/json_annotation.dart';

part 'single_league_goal_body.g.dart';

@JsonSerializable()
class SingleLeagueGoalBody {
  final int matchId;
  final int scoredByUserId;
  final int opponentId;
  final int scorerScore;
  final int opponentScore;
  final bool winnerGoal;

  SingleLeagueGoalBody({
    required this.matchId,
    required this.scoredByUserId,
    required this.opponentId,
    required this.scorerScore,
    required this.opponentScore,
    required this.winnerGoal,
  });

  factory SingleLeagueGoalBody.fromJson(Map<String, dynamic> item) =>
      _$SingleLeagueGoalBodyFromJson(item);

  Map<String, dynamic> toJson(item) => _$SingleLeagueGoalBodyToJson(item);
}
