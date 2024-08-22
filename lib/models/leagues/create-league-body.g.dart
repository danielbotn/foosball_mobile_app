// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create-league-body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateLeagueBody _$CreateLeagueBodyFromJson(Map<String, dynamic> json) =>
    CreateLeagueBody(
      name: json['name'] as String,
      typeOfLeague: (json['typeOfLeague'] as num).toInt(),
      upTo: (json['upTo'] as num).toInt(),
      organisationId: (json['organisationId'] as num).toInt(),
      howManyRounds: (json['howManyRounds'] as num).toInt(),
      hasLeagueStarted: json['hasLeagueStarted'] as bool?,
    );

Map<String, dynamic> _$CreateLeagueBodyToJson(CreateLeagueBody instance) =>
    <String, dynamic>{
      'name': instance.name,
      'typeOfLeague': instance.typeOfLeague,
      'upTo': instance.upTo,
      'organisationId': instance.organisationId,
      'howManyRounds': instance.howManyRounds,
      'hasLeagueStarted': instance.hasLeagueStarted,
    };
