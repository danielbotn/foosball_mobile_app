// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'freehand_double_match_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FreehandDoubleMatchModel _$FreehandDoubleMatchModelFromJson(
        Map<String, dynamic> json) =>
    FreehandDoubleMatchModel(
      id: json['id'] as int,
      playerOneTeamA: json['playerOneTeamA'] as int,
      playerOneTeamAFirstName: json['playerOneTeamAFirstName'] as String,
      playerOneTeamALastName: json['playerOneTeamALastName'] as String,
      playerOneTeamAPhotoUrl: json['playerOneTeamAPhotoUrl'] as String,
      playerTwoTeamA: json['playerTwoTeamA'] as int,
      playerTwoTeamAFirstName: json['playerTwoTeamAFirstName'] as String,
      playerTwoTeamALastName: json['playerTwoTeamALastName'] as String,
      playerTwoTeamAPhotoUrl: json['playerTwoTeamAPhotoUrl'] as String,
      playerOneTeamB: json['playerOneTeamB'] as int,
      playerOneTeamBFirstName: json['playerOneTeamBFirstName'] as String,
      playerOneTeamBLastName: json['playerOneTeamBLastName'] as String,
      playerOneTeamBPhotoUrl: json['playerOneTeamBPhotoUrl'] as String,
      playerTwoTeamB: json['playerTwoTeamB'] as int?,
      playerTwoTeamBFirstName: json['playerTwoTeamBFirstName'] as String?,
      playerTwoTeamBLastName: json['playerTwoTeamBLastName'] as String?,
      playerTwoTeamBPhotoUrl: json['playerTwoTeamBPhotoUrl'] as String?,
      organisationId: json['organisationId'] as int,
      startTime: DateTime.parse(json['startTime'] as String),
      endTime: DateTime.parse(json['endTime'] as String),
      totalPlayingTime: json['totalPlayingTime'] as String,
      teamAScore: json['teamAScore'] as int,
      teamBScore: json['teamBScore'] as int,
      nicknameTeamA: json['nicknameTeamA'] as String,
      nicknameTeamB: json['nicknameTeamB'] as String,
      upTo: json['upTo'] as int,
      gameFinished: json['gameFinished'] as bool,
      gamePaused: json['gamePaused'] as bool,
    );

Map<String, dynamic> _$FreehandDoubleMatchModelToJson(
        FreehandDoubleMatchModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'playerOneTeamA': instance.playerOneTeamA,
      'playerOneTeamAFirstName': instance.playerOneTeamAFirstName,
      'playerOneTeamALastName': instance.playerOneTeamALastName,
      'playerOneTeamAPhotoUrl': instance.playerOneTeamAPhotoUrl,
      'playerTwoTeamA': instance.playerTwoTeamA,
      'playerTwoTeamAFirstName': instance.playerTwoTeamAFirstName,
      'playerTwoTeamALastName': instance.playerTwoTeamALastName,
      'playerTwoTeamAPhotoUrl': instance.playerTwoTeamAPhotoUrl,
      'playerOneTeamB': instance.playerOneTeamB,
      'playerOneTeamBFirstName': instance.playerOneTeamBFirstName,
      'playerOneTeamBLastName': instance.playerOneTeamBLastName,
      'playerOneTeamBPhotoUrl': instance.playerOneTeamBPhotoUrl,
      'playerTwoTeamB': instance.playerTwoTeamB,
      'playerTwoTeamBFirstName': instance.playerTwoTeamBFirstName,
      'playerTwoTeamBLastName': instance.playerTwoTeamBLastName,
      'playerTwoTeamBPhotoUrl': instance.playerTwoTeamBPhotoUrl,
      'organisationId': instance.organisationId,
      'startTime': instance.startTime.toIso8601String(),
      'endTime': instance.endTime.toIso8601String(),
      'totalPlayingTime': instance.totalPlayingTime,
      'teamAScore': instance.teamAScore,
      'teamBScore': instance.teamBScore,
      'nicknameTeamA': instance.nicknameTeamA,
      'nicknameTeamB': instance.nicknameTeamB,
      'upTo': instance.upTo,
      'gameFinished': instance.gameFinished,
      'gamePaused': instance.gamePaused,
    };
