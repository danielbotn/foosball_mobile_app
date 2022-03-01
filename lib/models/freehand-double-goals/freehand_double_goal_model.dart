import 'package:json_annotation/json_annotation.dart';

part 'freehand_double_goal_model.g.dart';

@JsonSerializable()
class FreehandDoubleGoalModel {
  final int id;
  final int scoredByUserId;
  final int doubleMatchId;
  final int scorerTeamScore;
  final int opponentTeamScore;
  final bool winnerGoal;
  final DateTime timeOfGoal;
  final String goalTimeStopWatch;
  final String firstName;
  final String lastName;
  final String email;
  final String photoUrl;
  

  FreehandDoubleGoalModel(
      {required this.id,
      required this.scoredByUserId,
      required this.doubleMatchId,
      required this.scorerTeamScore,
      required this.opponentTeamScore,
      required this.winnerGoal,
      required this.timeOfGoal,
      required this.goalTimeStopWatch,
      required this.firstName,
      required this.lastName,
      required this.email,
      required this.photoUrl
      });

  factory FreehandDoubleGoalModel.fromJson(Map<String, dynamic> item) =>
      _$FreehandDoubleGoalModelFromJson(item);

  Map<String, dynamic> toJson(item) => _$FreehandDoubleGoalModelToJson(item);
}
