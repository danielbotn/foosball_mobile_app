import 'package:json_annotation/json_annotation.dart';

part 'organisation_response.g.dart';

@JsonSerializable()
class OrganisationResponse {
  final int id;
  final String name;
  final DateTime createdAt;
  final int organisationType;
  final String organisationCode;
  final String? slackWebhookUrl;
  final String? discordWebhookUrl;
  final String? microsoftTeamsWebhookUrl;

  OrganisationResponse(
      {required this.id,
      required this.name,
      required this.createdAt,
      required this.organisationType,
      required this.organisationCode,
      required this.slackWebhookUrl,
      required this.discordWebhookUrl,
      required this.microsoftTeamsWebhookUrl});

  factory OrganisationResponse.fromJson(Map<String, dynamic> item) =>
      _$OrganisationResponseFromJson(item);

  Map<String, dynamic> toJson(item) => _$OrganisationResponseToJson(item);
}
