// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create-league-body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateLeagueBody _$CreateLeagueBodyFromJson(Map<String, dynamic> json) =>
    CreateLeagueBody(
      name: json['name'] as String,
      typeOfLeague: json['typeOfLeague'] as int,
      upTo: json['upTo'] as int,
      organisationId: json['organisationId'] as int,
      howManyRounds: json['howManyRounds'] as int,
    );

Map<String, dynamic> _$CreateLeagueBodyToJson(CreateLeagueBody instance) =>
    <String, dynamic>{
      'name': instance.name,
      'typeOfLeague': instance.typeOfLeague,
      'upTo': instance.upTo,
      'organisationId': instance.organisationId,
      'howManyRounds': instance.howManyRounds,
    };
