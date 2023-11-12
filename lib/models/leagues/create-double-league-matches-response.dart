import 'package:foosball_mobile_app/models/double-league-matches/double_league_match_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'create-double-league-matches-response.g.dart';

@JsonSerializable()
class CreateDoubleLeagueMatchesResponse {
  final List<DoubleLeagueMatchModel> matches;

  CreateDoubleLeagueMatchesResponse({
    required this.matches,
  });

  factory CreateDoubleLeagueMatchesResponse.fromJson(
          Map<String, dynamic> item) =>
      _$CreateDoubleLeagueMatchesResponseFromJson(item);

  Map<String, dynamic> toJson(item) =>
      _$CreateDoubleLeagueMatchesResponseToJson(item);
}
