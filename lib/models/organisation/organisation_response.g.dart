// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'organisation_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrganisationResponse _$OrganisationResponseFromJson(
        Map<String, dynamic> json) =>
    OrganisationResponse(
      id: json['id'] as int,
      name: json['name'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      organisationType: json['organisationType'] as int,
      organisationCode: json['organisationCode'] as String,
      slackWebhookUrl: json['slackWebhookUrl'] as String?,
      discordWebhookUrl: json['discordWebhookUrl'] as String?,
      microsoftTeamsWebhookUrl: json['microsoftTeamsWebhookUrl'] as String?,
    );

Map<String, dynamic> _$OrganisationResponseToJson(
        OrganisationResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'createdAt': instance.createdAt.toIso8601String(),
      'organisationType': instance.organisationType,
      'organisationCode': instance.organisationCode,
      'slackWebhookUrl': instance.slackWebhookUrl,
      'discordWebhookUrl': instance.discordWebhookUrl,
      'microsoftTeamsWebhookUrl': instance.microsoftTeamsWebhookUrl,
    };
