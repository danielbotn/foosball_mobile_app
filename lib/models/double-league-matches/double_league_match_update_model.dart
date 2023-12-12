import 'package:json_annotation/json_annotation.dart';

part 'double_league_match_update_model.g.dart';

@JsonSerializable()
class DoubleLeagueMatchUpdateModel {
  final DateTime? startTime;
  final DateTime? endTime;
  final int? teamOneScore;
  final int? teamTwoScore;
  final bool? matchStarted;
  final bool? matchEnded;
  final bool? matchPaused;

  DoubleLeagueMatchUpdateModel({
    required this.startTime,
    required this.endTime,
    required this.teamOneScore,
    required this.teamTwoScore,
    required this.matchStarted,
    required this.matchEnded,
    required this.matchPaused,
  });

  factory DoubleLeagueMatchUpdateModel.fromJson(Map<String, dynamic> item) =>
      _$DoubleLeagueMatchUpdateModelFromJson(item);

  Map<String, dynamic> toJson(item) =>
      _$DoubleLeagueMatchUpdateModelToJson(item);
}
