// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create-league-response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateLeagueResponse _$CreateLeagueResponseFromJson(
        Map<String, dynamic> json) =>
    CreateLeagueResponse(
      id: json['id'] as int,
      name: json['name'] as String,
      typeOfLeague: json['typeOfLeague'] as int,
      createdAt: DateTime.parse(json['createdAt'] as String),
      organisationId: json['organisationId'] as int,
      upTo: json['upTo'] as int,
      hasLeagueStarted: json['hasLeagueStarted'] as bool,
      howManyRounds: json['howManyRounds'] as int,
    );

Map<String, dynamic> _$CreateLeagueResponseToJson(
        CreateLeagueResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'typeOfLeague': instance.typeOfLeague,
      'createdAt': instance.createdAt.toIso8601String(),
      'upTo': instance.upTo,
      'organisationId': instance.organisationId,
      'hasLeagueStarted': instance.hasLeagueStarted,
      'howManyRounds': instance.howManyRounds,
    };