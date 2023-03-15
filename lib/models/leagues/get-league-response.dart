import 'package:json_annotation/json_annotation.dart';

part 'get-league-response.g.dart';

@JsonSerializable()
class GetLeagueResponse {
  final int id;
  final String name;
  final int typeOfLeague;
  final DateTime createdAt;
  final int upTo;
  final int organisationId;
  final bool hasLeagueStarted;
  final int howManyRounds;

  GetLeagueResponse(
      {required this.id,
      required this.name,
      required this.typeOfLeague,
      required this.createdAt,
      required this.organisationId,
      required this.upTo,
      required this.hasLeagueStarted,
      required this.howManyRounds});

  factory GetLeagueResponse.fromJson(Map<String, dynamic> item) =>
      _$GetLeagueResponseFromJson(item);

  Map<String, dynamic> toJson(item) => _$GetLeagueResponseToJson(item);
}
