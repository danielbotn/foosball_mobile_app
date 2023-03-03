import 'package:json_annotation/json_annotation.dart';

part 'create-league-body.g.dart';

@JsonSerializable()
class CreateLeagueBody {
  final String name;
  final int typeOfLeague;
  final int upTo;
  final int organisationId;
  final int howManyRounds;

  CreateLeagueBody(
      {required this.name,
      required this.typeOfLeague,
      required this.upTo,
      required this.organisationId,
      required this.howManyRounds});

  factory CreateLeagueBody.fromJson(Map<String, dynamic> item) =>
      _$CreateLeagueBodyFromJson(item);

  Map<String, dynamic> toJson(item) => _$CreateLeagueBodyToJson(item);
}
