import 'package:foosball_mobile_app/models/double-league-matches/team_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'double_league_match_model.g.dart';

@JsonSerializable(explicitToJson: true)
class DoubleLeagueMatchModel {
  final int id;
  final int teamOneId;
  final int teamTwoId;
  final int leagueId;
  final DateTime? startTime;
  final DateTime? endTime;
  final int teamOneScore;
  final int teamTwoScore;
  final bool matchStarted;
  final bool matchEnded;
  final bool matchPaused;
  final String? totalPlayingTime;
  final List<TeamModel> teamOne;
  final List<TeamModel> teamTwo;

  DoubleLeagueMatchModel({
    required this.id,
    required this.teamOneId,
    required this.teamTwoId,
    required this.leagueId,
    required this.startTime,
    required this.endTime,
    required this.teamOneScore,
    required this.teamTwoScore,
    required this.matchStarted,
    required this.matchEnded,
    required this.matchPaused,
    required this.totalPlayingTime,
    required this.teamOne,
    required this.teamTwo,
  });

  factory DoubleLeagueMatchModel.fromJson(Map<String, dynamic> json) => _$DoubleLeagueMatchModelFromJson(json);

  Map<String, dynamic> toJson() => _$DoubleLeagueMatchModelToJson(this);
}