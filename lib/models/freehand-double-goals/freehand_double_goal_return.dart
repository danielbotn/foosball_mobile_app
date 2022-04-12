import 'package:json_annotation/json_annotation.dart';

part 'freehand_double_goal_return.g.dart';

@JsonSerializable()
class FreehandDoubleGoalReturn {
  final int doubleMatchId;
  final int scoredByUserId;
  final int scorerTeamScore;
  final int opponentTeamScore;
  final bool winnerGoal;

  FreehandDoubleGoalReturn({
    required this.doubleMatchId,
    required this.scoredByUserId,
    required this.scorerTeamScore,
    required this.opponentTeamScore,
    required this.winnerGoal,
  });

  factory FreehandDoubleGoalReturn.fromJson(Map<String, dynamic> item) =>
      _$FreehandDoubleGoalReturnFromJson(item);

  Map<String, dynamic> toJson(item) => _$FreehandDoubleGoalReturnToJson(item);
}
