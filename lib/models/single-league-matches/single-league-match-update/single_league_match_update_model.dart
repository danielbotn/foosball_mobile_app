import 'package:json_annotation/json_annotation.dart';

part 'single_league_match_update_model.g.dart';

@JsonSerializable()
class SingleLeagueMatchUpdateModel {
  final DateTime? startTime;
  final DateTime? endTime;
  final int? playerOneScore;
  final int? playerTwoScore;
  final bool? matchStarted;
  final bool? matchEnded;
  final bool? matchPaused;

  SingleLeagueMatchUpdateModel({
    required this.startTime,
    required this.endTime,
    required this.playerOneScore,
    required this.playerTwoScore,
    required this.matchStarted,
    required this.matchEnded,
    required this.matchPaused,
  });

  factory SingleLeagueMatchUpdateModel.fromJson(Map<String, dynamic> item) =>
      _$SingleLeagueMatchUpdateModelFromJson(item);

  Map<String, dynamic> toJson(item) =>
      _$SingleLeagueMatchUpdateModelToJson(item);
}
