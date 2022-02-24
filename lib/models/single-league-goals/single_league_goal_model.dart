import 'package:json_annotation/json_annotation.dart';

part 'single_league_goal_model.g.dart';

@JsonSerializable()
class SingleLeagueGoalModel {
  final int id;
  final DateTime timeOfGoal;
  final int matchId;
  final int scoredByUserId;
  final String scoredByUserFirstName;
  final String scoredByUserLastName;
  final String scoredByUserPhotoUrl;
  final int opponentId;
  final String opponentFirstName;
  final String opponentLastName;
  final String opponentPhotoUrl;
  final int scorerScore;
  final int opponentScore;
  final bool winnerGoal;
  final String goalTimeStopWatch;
  

  SingleLeagueGoalModel(
      {required this.id,
      required this.timeOfGoal,
      required this.matchId,
      required this.scoredByUserId,
      required this.scoredByUserFirstName,
      required this.scoredByUserLastName,
      required this.scoredByUserPhotoUrl,
      required this.opponentId,
      required this.opponentFirstName,
      required this.opponentLastName,
      required this.opponentPhotoUrl,
      required this.scorerScore,
      required this.opponentScore,
      required this.winnerGoal,
      required this.goalTimeStopWatch
      });

  factory SingleLeagueGoalModel.fromJson(Map<String, dynamic> item) =>
      _$SingleLeagueGoalModelFromJson(item);

  Map<String, dynamic> toJson(item) => _$SingleLeagueGoalModelToJson(item);
}
