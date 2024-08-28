import 'package:json_annotation/json_annotation.dart';

part 'goal_info.g.dart';

@JsonSerializable()
class PlayerInfo {
  final int id;
  final String firstName;
  final String lastName;
  final String photoUrl;

  PlayerInfo({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.photoUrl,
  });

  factory PlayerInfo.fromJson(Map<String, dynamic> json) =>
      _$PlayerInfoFromJson(json);

  Map<String, dynamic> toJson() => _$PlayerInfoToJson(this);
}

@JsonSerializable()
class GoalInfo {
  final int scoredByUserId;
  final int scorerTeamScore;
  final int opponentTeamScore;
  final DateTime timeOfGoal;
  final bool winnerGoal;
  final PlayerInfo scorer;

  GoalInfo({
    required this.scoredByUserId,
    required this.scorerTeamScore,
    required this.opponentTeamScore,
    required this.timeOfGoal,
    required this.winnerGoal,
    required this.scorer,
  });

  factory GoalInfo.fromJson(Map<String, dynamic> json) =>
      _$GoalInfoFromJson(json);

  Map<String, dynamic> toJson() => _$GoalInfoToJson(this);
}
