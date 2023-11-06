import 'package:json_annotation/json_annotation.dart';

part 'create_double_league_team_return.g.dart';

@JsonSerializable()
class CreateDoubleLeagueTeamReturn {
  final int id;
  final String name;
  final DateTime createdAt;
  final int organisationId;
  final int leagueId;
  CreateDoubleLeagueTeamReturn({
    required this.id,
    required this.name,
    required this.createdAt,
    required this.organisationId,
    required this.leagueId,
  });

  factory CreateDoubleLeagueTeamReturn.fromJson(Map<String, dynamic> item) =>
      _$CreateDoubleLeagueTeamReturnFromJson(item);

  Map<String, dynamic> toJson(item) =>
      _$CreateDoubleLeagueTeamReturnToJson(item);
}
