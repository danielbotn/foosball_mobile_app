import 'package:json_annotation/json_annotation.dart';

part 'game_score.g.dart';

@JsonSerializable()
class GameScore {
  final String teamName;
  final int teamScore;
  final int opponentTeamScore;
  final String timeOfGoal;

  GameScore({
    required this.teamName,
    required this.teamScore,
    required this.opponentTeamScore,
    required this.timeOfGoal,
  });

  factory GameScore.fromJson(Map<String, dynamic> json) =>
      _$GameScoreFromJson(json);

  Map<String, dynamic> toJson() => _$GameScoreToJson(this);
}
