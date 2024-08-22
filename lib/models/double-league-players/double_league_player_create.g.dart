// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'double_league_player_create.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DoubleLeaguePlayerCreate _$DoubleLeaguePlayerCreateFromJson(
        Map<String, dynamic> json) =>
    DoubleLeaguePlayerCreate(
      playerOneId: (json['playerOneId'] as num).toInt(),
      playerTwoId: (json['playerTwoId'] as num).toInt(),
      insertionSuccessfull: json['insertionSuccessfull'] as bool,
    );

Map<String, dynamic> _$DoubleLeaguePlayerCreateToJson(
        DoubleLeaguePlayerCreate instance) =>
    <String, dynamic>{
      'playerOneId': instance.playerOneId,
      'playerTwoId': instance.playerTwoId,
      'insertionSuccessfull': instance.insertionSuccessfull,
    };
