// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create-double-league-matches-response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateDoubleLeagueMatchesResponse _$CreateDoubleLeagueMatchesResponseFromJson(
        Map<String, dynamic> json) =>
    CreateDoubleLeagueMatchesResponse(
      matches: (json['matches'] as List<dynamic>)
          .map(
              (e) => DoubleLeagueMatchModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CreateDoubleLeagueMatchesResponseToJson(
        CreateDoubleLeagueMatchesResponse instance) =>
    <String, dynamic>{
      'matches': instance.matches,
    };
