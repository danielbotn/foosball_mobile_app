import 'package:json_annotation/json_annotation.dart';

part 'freehand_goal_model.g.dart';

@JsonSerializable()
class FreehandGoalModel {
  final int id;
  final DateTime timeOfGoal;
  final int matchId;
  final int scoredByUserId;
  final int oponentId;
  final int scoredByScore;
  final int oponentScore;
  final bool winnerGoal;
  

  FreehandGoalModel(
      {required this.id,
      required this.timeOfGoal,
      required this.matchId,
      required this.scoredByUserId,
      required this.oponentId,
      required this.scoredByScore,
      required this.oponentScore,
      required this.winnerGoal,
      });

  factory FreehandGoalModel.fromJson(Map<String, dynamic> item) =>
      _$FreehandGoalModelFromJson(item);

  Map<String, dynamic> toJson(item) => _$FreehandGoalModelToJson(item);
}
