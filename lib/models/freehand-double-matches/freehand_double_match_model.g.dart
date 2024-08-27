// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'freehand_double_match_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FreehandDoubleMatchModel _$FreehandDoubleMatchModelFromJson(
        Map<String, dynamic> json) =>
    FreehandDoubleMatchModel(
      id: (json['id'] as num).toInt(),
      playerOneTeamA: (json['playerOneTeamA'] as num).toInt(),
      playerOneTeamAFirstName: json['playerOneTeamAFirstName'] as String,
      playerOneTeamALastName: json['playerOneTeamALastName'] as String,
      playerOneTeamAPhotoUrl: json['playerOneTeamAPhotoUrl'] as String,
      playerTwoTeamA: (json['playerTwoTeamA'] as num).toInt(),
      playerTwoTeamAFirstName: json['playerTwoTeamAFirstName'] as String,
      playerTwoTeamALastName: json['playerTwoTeamALastName'] as String,
      playerTwoTeamAPhotoUrl: json['playerTwoTeamAPhotoUrl'] as String,
      playerOneTeamB: (json['playerOneTeamB'] as num).toInt(),
      playerOneTeamBFirstName: json['playerOneTeamBFirstName'] as String,
      playerOneTeamBLastName: json['playerOneTeamBLastName'] as String,
      playerOneTeamBPhotoUrl: json['playerOneTeamBPhotoUrl'] as String,
      playerTwoTeamB: (json['playerTwoTeamB'] as num?)?.toInt(),
      playerTwoTeamBFirstName: json['playerTwoTeamBFirstName'] as String?,
      playerTwoTeamBLastName: json['playerTwoTeamBLastName'] as String?,
      playerTwoTeamBPhotoUrl: json['playerTwoTeamBPhotoUrl'] as String?,
      organisationId: (json['organisationId'] as num).toInt(),
      startTime: DateTime.parse(json['startTime'] as String),
      endTime: json['endTime'] == null
          ? null
          : DateTime.parse(json['endTime'] as String),
      totalPlayingTime: json['totalPlayingTime'] as String?,
      teamAScore: (json['teamAScore'] as num).toInt(),
      teamBScore: (json['teamBScore'] as num).toInt(),
      nicknameTeamA: json['nicknameTeamA'] as String,
      nicknameTeamB: json['nicknameTeamB'] as String,
      upTo: (json['upTo'] as num).toInt(),
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
      'endTime': instance.endTime?.toIso8601String(),
      'totalPlayingTime': instance.totalPlayingTime,
      'teamAScore': instance.teamAScore,
      'teamBScore': instance.teamBScore,
      'nicknameTeamA': instance.nicknameTeamA,
      'nicknameTeamB': instance.nicknameTeamB,
      'upTo': instance.upTo,
      'gameFinished': instance.gameFinished,
      'gamePaused': instance.gamePaused,
    };
