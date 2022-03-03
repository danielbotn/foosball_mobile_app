import 'package:json_annotation/json_annotation.dart';

part 'double_league_goal_model.g.dart';

@JsonSerializable()
class DoubleLeagueGoalModel {
  final int id;
  final DateTime timeOfGoal;
  final int scoredByTeamId;
  final int opponentTeamId;
  final int scorerTeamScore;
  final int opponentTeamScore;
  final bool winnerGoal;
  final int userScorerId;
  final int doubleLeagueTeamId;
  final String scorerFirstName;
  final String scorerLastName;
  final String scorerPhotoUrl;
  final String goalTimeStopWatch;

  DoubleLeagueGoalModel(
      {required this.id,
      required this.timeOfGoal,
      required this.scoredByTeamId,
      required this.opponentTeamId,
      required this.scorerTeamScore,
      required this.opponentTeamScore,
      required this.winnerGoal,
      required this.userScorerId,
      required this.doubleLeagueTeamId,
      required this.scorerFirstName,
      required this.scorerLastName,
      required this.scorerPhotoUrl,
      required this.goalTimeStopWatch});

  factory DoubleLeagueGoalModel.fromJson(Map<String, dynamic> item) =>
      _$DoubleLeagueGoalModelFromJson(item);

  Map<String, dynamic> toJson(item) => _$DoubleLeagueGoalModelToJson(item);
}
