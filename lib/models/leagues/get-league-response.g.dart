// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get-league-response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetLeagueResponse _$GetLeagueResponseFromJson(Map<String, dynamic> json) =>
    GetLeagueResponse(
      id: json['id'] as int,
      name: json['name'] as String,
      typeOfLeague: json['typeOfLeague'] as int,
      createdAt: DateTime.parse(json['createdAt'] as String),
      organisationId: json['organisationId'] as int,
      upTo: json['upTo'] as int,
      hasLeagueStarted: json['hasLeagueStarted'] as bool,
      howManyRounds: json['howManyRounds'] as int,
      hasLeagueEnded: json['hasLeagueEnded'] as bool?,
      hasAccess: json['hasAccess'] as bool?,
    );

Map<String, dynamic> _$GetLeagueResponseToJson(GetLeagueResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'typeOfLeague': instance.typeOfLeague,
      'createdAt': instance.createdAt.toIso8601String(),
      'upTo': instance.upTo,
      'organisationId': instance.organisationId,
      'hasLeagueStarted': instance.hasLeagueStarted,
      'howManyRounds': instance.howManyRounds,
      'hasLeagueEnded': instance.hasLeagueEnded,
      'hasAccess': instance.hasAccess,
    };
