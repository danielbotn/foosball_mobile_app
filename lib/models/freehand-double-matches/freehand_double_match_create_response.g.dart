// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'freehand_double_match_create_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FreehandDoubleMatchCreateResponse _$FreehandDoubleMatchCreateResponseFromJson(
        Map<String, dynamic> json) =>
    FreehandDoubleMatchCreateResponse(
      id: (json['id'] as num).toInt(),
      playerOneTeamA: (json['playerOneTeamA'] as num).toInt(),
      playerOneTeamB: (json['playerOneTeamB'] as num).toInt(),
      playerTwoTeamA: (json['playerTwoTeamA'] as num).toInt(),
      playerTwoTeamB: (json['playerTwoTeamB'] as num).toInt(),
      startTime: DateTime.parse(json['startTime'] as String),
      endTime: json['endTime'] == null
          ? null
          : DateTime.parse(json['endTime'] as String),
      upTo: (json['upTo'] as num).toInt(),
      gameFinished: json['gameFinished'] as bool,
      gamePaused: json['gamePaused'] as bool,
      organisationId: (json['organisationId'] as num).toInt(),
      nicknameTeamA: json['nicknameTeamA'] as String?,
      nicknameTeamB: json['nicknameTeamB'] as String?,
    );

Map<String, dynamic> _$FreehandDoubleMatchCreateResponseToJson(
        FreehandDoubleMatchCreateResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'playerOneTeamA': instance.playerOneTeamA,
      'playerOneTeamB': instance.playerOneTeamB,
      'playerTwoTeamA': instance.playerTwoTeamA,
      'playerTwoTeamB': instance.playerTwoTeamB,
      'startTime': instance.startTime.toIso8601String(),
      'endTime': instance.endTime?.toIso8601String(),
      'upTo': instance.upTo,
      'gameFinished': instance.gameFinished,
      'gamePaused': instance.gamePaused,
      'organisationId': instance.organisationId,
      'nicknameTeamA': instance.nicknameTeamA,
      'nicknameTeamB': instance.nicknameTeamB,
    };
