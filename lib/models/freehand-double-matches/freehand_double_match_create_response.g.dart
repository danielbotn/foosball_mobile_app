// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'freehand_double_match_create_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FreehandDoubleMatchCreateResponse _$FreehandDoubleMatchCreateResponseFromJson(
    Map<String, dynamic> json) {
  return FreehandDoubleMatchCreateResponse(
    id: json['id'] as int,
    playerOneTeamA: json['playerOneTeamA'] as int,
    playerOneTeamB: json['playerOneTeamB'] as int,
    playerTwoTeamA: json['playerTwoTeamA'] as int,
    playerTwoTeamB: json['playerTwoTeamB'] as int,
    startTime: DateTime.parse(json['startTime'] as String),
    endTime: json['endTime'] == null
        ? null
        : DateTime.parse(json['endTime'] as String),
    upTo: json['upTo'] as int,
    gameFinished: json['gameFinished'] as bool,
    gamePaused: json['gamePaused'] as bool,
    organisationId: json['organisationId'] as int,
    nicknameTeamA: json['nicknameTeamA'] as String?,
    nicknameTeamB: json['nicknameTeamB'] as String?,
  );
}

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
