// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'freehand_match_create_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FreehandMatchCreateResponse _$FreehandMatchCreateResponseFromJson(
        Map<String, dynamic> json) =>
    FreehandMatchCreateResponse(
      id: json['id'] as int,
      playerOneId: json['playerOneId'] as int,
      playerTwoId: json['playerTwoId'] as int,
      startTime: DateTime.parse(json['startTime'] as String),
      endTime: json['endTime'] == null
          ? null
          : DateTime.parse(json['endTime'] as String),
      playerOneScore: json['playerOneScore'] as int,
      playerTwoScore: json['playerTwoScore'] as int,
      upTo: json['upTo'] as int,
      gameFinished: json['gameFinished'] as bool,
      gamePaused: json['gamePaused'] as bool,
      organisationId: json['organisationId'] as int,
    );

Map<String, dynamic> _$FreehandMatchCreateResponseToJson(
        FreehandMatchCreateResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'playerOneId': instance.playerOneId,
      'playerTwoId': instance.playerTwoId,
      'startTime': instance.startTime.toIso8601String(),
      'endTime': instance.endTime?.toIso8601String(),
      'playerOneScore': instance.playerOneScore,
      'playerTwoScore': instance.playerTwoScore,
      'upTo': instance.upTo,
      'gameFinished': instance.gameFinished,
      'gamePaused': instance.gamePaused,
      'organisationId': instance.organisationId,
    };
