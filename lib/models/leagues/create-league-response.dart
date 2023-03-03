import 'package:json_annotation/json_annotation.dart';

part 'create-league-response.g.dart';

@JsonSerializable()
class CreateLeagueResponse {
  final int id;
  final String name;
  final int typeOfLeague;
  final DateTime createdAt;
  final int upTo;
  final int organisationId;
  final bool hasLeagueStarted;
  final int howManyRounds;

  CreateLeagueResponse(
      {required this.id,
      required this.name,
      required this.typeOfLeague,
      required this.createdAt,
      required this.organisationId,
      required this.upTo,
      required this.hasLeagueStarted,
      required this.howManyRounds});

  factory CreateLeagueResponse.fromJson(Map<String, dynamic> item) =>
      _$CreateLeagueResponseFromJson(item);

  Map<String, dynamic> toJson(item) => _$CreateLeagueResponseToJson(item);
}
