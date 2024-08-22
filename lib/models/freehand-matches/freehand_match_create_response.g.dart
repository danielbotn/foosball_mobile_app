// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'freehand_match_create_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FreehandMatchCreateResponse _$FreehandMatchCreateResponseFromJson(
        Map<String, dynamic> json) =>
    FreehandMatchCreateResponse(
      id: (json['id'] as num).toInt(),
      playerOneId: (json['playerOneId'] as num).toInt(),
      playerTwoId: (json['playerTwoId'] as num).toInt(),
      startTime: DateTime.parse(json['startTime'] as String),
      endTime: json['endTime'] == null
          ? null
          : DateTime.parse(json['endTime'] as String),
      playerOneScore: (json['playerOneScore'] as num).toInt(),
      playerTwoScore: (json['playerTwoScore'] as num).toInt(),
      upTo: (json['upTo'] as num).toInt(),
      gameFinished: json['gameFinished'] as bool,
      gamePaused: json['gamePaused'] as bool,
      organisationId: (json['organisationId'] as num).toInt(),
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
