import 'package:json_annotation/json_annotation.dart';

part 'single_league_goal_model.g.dart';

@JsonSerializable()
class SingleLeagueGoalModel {
  final int id;
  final DateTime timeOfGoal;
  final int matchId;
  final int scoredByUserId;
  final int opponentId;
  final int scorerScore;
  final int opponentScore;
  final bool winnerGoal;
  

  SingleLeagueGoalModel(
      {required this.id,
      required this.timeOfGoal,
      required this.matchId,
      required this.scoredByUserId,
      required this.opponentId,
      required this.scorerScore,
      required this.opponentScore,
      required this.winnerGoal,
      });

  factory SingleLeagueGoalModel.fromJson(Map<String, dynamic> item) =>
      _$SingleLeagueGoalModelFromJson(item);

  Map<String, dynamic> toJson(item) => _$SingleLeagueGoalModelToJson(item);
}
