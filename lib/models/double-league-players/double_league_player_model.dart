import 'package:json_annotation/json_annotation.dart';

part 'double_league_player_model.g.dart';

@JsonSerializable(explicitToJson: true)
class DoubleLeaguePlayerModel {
  final int id;
  final int userId;
  final int doubleLeagueTeamId;
  final String firstName;
  final String lastName;
  final String email;
  final int teamId;
  final String teamName;

  DoubleLeaguePlayerModel(
      {required this.id,
      required this.userId,
      required this.doubleLeagueTeamId,
      required this.firstName,
      required this.lastName,
      required this.email,
      required this.teamId,
      required this.teamName});

  factory DoubleLeaguePlayerModel.fromJson(Map<String, dynamic> json) =>
      _$DoubleLeaguePlayerModelFromJson(json);

  Map<String, dynamic> toJson() => _$DoubleLeaguePlayerModelToJson(this);
}
