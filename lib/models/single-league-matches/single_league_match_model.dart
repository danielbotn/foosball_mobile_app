import 'package:json_annotation/json_annotation.dart';

part 'single_league_match_model.g.dart';

@JsonSerializable()
class SingleLeagueMatchModel {
  final int id;
  final int playerOne;
  final String playerOneFirstName;
  final String playerOneLastName;
  final String playerOnePhotoUrl;
  final int playerTwo;
  final String playerTwoFirstName;
  final String playerTwoLastName;
  final String playerTwoPhotoUrl;
  final int leagueId;
  final DateTime? startTime;
  final DateTime? endTime;
  final int? playerOneScore;
  final int? playerTwoScore;
  final bool? matchStarted;
  final bool? matchEnded;
  final bool? matchPaused;
  final String? totalPlayingTime;
  

  SingleLeagueMatchModel(
      {required this.id,
      required this.playerOne,
      required this.playerOneFirstName,
      required this.playerOneLastName,
      required this.playerOnePhotoUrl,
      required this.playerTwo,
      required this.playerTwoFirstName,
      required this.playerTwoLastName,
      required this.playerTwoPhotoUrl,
      required this.leagueId,
      required this.startTime,
      required this.endTime,
      required this.playerOneScore,
      required this.playerTwoScore,
      required this.matchStarted,
      required this.matchEnded,
      required this.matchPaused,
      required this.totalPlayingTime
      });

  factory SingleLeagueMatchModel.fromJson(Map<String, dynamic> item) =>
      _$SingleLeagueMatchModelFromJson(item);

  Map<String, dynamic> toJson(item) => _$SingleLeagueMatchModelToJson(item);

}
