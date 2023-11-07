import 'package:foosball_mobile_app/models/leagues/team-member-model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'double-league-standings-model.g.dart';

@JsonSerializable()
class DoubleLeagueStandingsModel {
  final int teamID;
  final int leagueId;
  final int totalMatchesWon;
  final int totalMatchesLost;
  final int totalGoalsScored;
  final int totalGoalsRecieved;
  final int positionInLeague;
  final int matchesPlayed;
  final int points;
  final String teamName;
  final List<TeamMemberModel> teamMembers;

  DoubleLeagueStandingsModel(
      {required this.teamID,
      required this.leagueId,
      required this.totalMatchesWon,
      required this.totalMatchesLost,
      required this.totalGoalsScored,
      required this.totalGoalsRecieved,
      required this.positionInLeague,
      required this.matchesPlayed,
      required this.points,
      required this.teamName,
      required this.teamMembers});

  factory DoubleLeagueStandingsModel.fromJson(Map<String, dynamic> item) =>
      _$DoubleLeagueStandingsModelFromJson(item);

  Map<String, dynamic> toJson(item) => _$DoubleLeagueStandingsModelToJson(item);
}
