import 'package:json_annotation/json_annotation.dart';

part 'create_double_league_matches_response.g.dart';

@JsonSerializable(explicitToJson: true)
class CreateDoubleLeagueMatchesResponse {
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

  CreateDoubleLeagueMatchesResponse({
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
  });

  factory CreateDoubleLeagueMatchesResponse.fromJson(
          Map<String, dynamic> json) =>
      _$CreateDoubleLeagueMatchesResponseFromJson(json);

  Map<String, dynamic> toJson() =>
      _$CreateDoubleLeagueMatchesResponseToJson(this);
}
