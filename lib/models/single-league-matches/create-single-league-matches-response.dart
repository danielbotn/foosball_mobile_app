import 'package:json_annotation/json_annotation.dart';

part 'create-single-league-matches-response.g.dart';

@JsonSerializable(explicitToJson: true)
class CreateSingleLeagueMatchesResponse {
  final int id;
  final int playerOne;
  final int playerTwo;
  final int leagueId;
  final DateTime? startTime;
  final DateTime? endTime;
  final int playerOneScore;
  final int playerTwoScore;
  final bool matchStarted;
  final bool matchEnded;
  final bool matchPaused;

  CreateSingleLeagueMatchesResponse({
    required this.id,
    required this.playerOne,
    required this.playerTwo,
    required this.leagueId,
    required this.startTime,
    required this.endTime,
    required this.playerOneScore,
    required this.playerTwoScore,
    required this.matchStarted,
    required this.matchEnded,
    required this.matchPaused,
  });

  factory CreateSingleLeagueMatchesResponse.fromJson(
          Map<String, dynamic> json) =>
      _$CreateSingleLeagueMatchesResponseFromJson(json);

  Map<String, dynamic> toJson() =>
      _$CreateSingleLeagueMatchesResponseToJson(this);
}
