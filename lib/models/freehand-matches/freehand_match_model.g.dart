// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'freehand_match_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FreehandMatchModel _$FreehandMatchModelFromJson(Map<String, dynamic> json) =>
    FreehandMatchModel(
      id: (json['id'] as num).toInt(),
      playerOneId: (json['playerOneId'] as num).toInt(),
      playerOneFirstName: json['playerOneFirstName'] as String,
      playerOneLastName: json['playerOneLastName'] as String,
      playerOnePhotoUrl: json['playerOnePhotoUrl'] as String,
      playerTwoId: (json['playerTwoId'] as num).toInt(),
      playerTwoFirstName: json['playerTwoFirstName'] as String,
      playerTwoLastName: json['playerTwoLastName'] as String,
      playerTwoPhotoUrl: json['playerTwoPhotoUrl'] as String,
      startTime: DateTime.parse(json['startTime'] as String),
      endTime: DateTime.parse(json['endTime'] as String),
      totalPlayingTime: json['totalPlayingTime'] as String?,
      playerOneScore: (json['playerOneScore'] as num).toInt(),
      playerTwoScore: (json['playerTwoScore'] as num).toInt(),
      upTo: (json['upTo'] as num).toInt(),
      gameFinished: json['gameFinished'] as bool,
      gamePaused: json['gamePaused'] as bool,
    );

Map<String, dynamic> _$FreehandMatchModelToJson(FreehandMatchModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'playerOneId': instance.playerOneId,
      'playerOneFirstName': instance.playerOneFirstName,
      'playerOneLastName': instance.playerOneLastName,
      'playerOnePhotoUrl': instance.playerOnePhotoUrl,
      'playerTwoId': instance.playerTwoId,
      'playerTwoFirstName': instance.playerTwoFirstName,
      'playerTwoLastName': instance.playerTwoLastName,
      'playerTwoPhotoUrl': instance.playerTwoPhotoUrl,
      'startTime': instance.startTime.toIso8601String(),
      'endTime': instance.endTime.toIso8601String(),
      'totalPlayingTime': instance.totalPlayingTime,
      'playerOneScore': instance.playerOneScore,
      'playerTwoScore': instance.playerTwoScore,
      'upTo': instance.upTo,
      'gameFinished': instance.gameFinished,
      'gamePaused': instance.gamePaused,
    };
