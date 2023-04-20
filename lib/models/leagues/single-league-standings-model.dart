import 'package:json_annotation/json_annotation.dart';

part 'single-league-standings-model.g.dart';

@JsonSerializable()
class SingleLeagueStandingsModel {
  final int userId;
  final int leagueId;
  final int totalMatchesWon;
  final int totalMatchesLost;
  final int totalGoalsScored;
  final int totalGoalsRecieved;
  final int positionInLeague;
  final int points;
  final String firstName;
  final String lastName;
  final String email;

  SingleLeagueStandingsModel(
      {required this.userId,
      required this.leagueId,
      required this.totalMatchesWon,
      required this.totalMatchesLost,
      required this.totalGoalsScored,
      required this.totalGoalsRecieved,
      required this.positionInLeague,
      required this.points,
      required this.firstName,
      required this.lastName,
      required this.email});

  factory SingleLeagueStandingsModel.fromJson(Map<String, dynamic> item) =>
      _$SingleLeagueStandingsModelFromJson(item);

  Map<String, dynamic> toJson(item) => _$SingleLeagueStandingsModelToJson(item);
}
