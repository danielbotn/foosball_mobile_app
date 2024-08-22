// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'single_league_match_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SingleLeagueMatchModel _$SingleLeagueMatchModelFromJson(
        Map<String, dynamic> json) =>
    SingleLeagueMatchModel(
      id: (json['id'] as num).toInt(),
      playerOne: (json['playerOne'] as num).toInt(),
      playerOneFirstName: json['playerOneFirstName'] as String,
      playerOneLastName: json['playerOneLastName'] as String,
      playerOnePhotoUrl: json['playerOnePhotoUrl'] as String,
      playerTwo: (json['playerTwo'] as num).toInt(),
      playerTwoFirstName: json['playerTwoFirstName'] as String,
      playerTwoLastName: json['playerTwoLastName'] as String,
      playerTwoPhotoUrl: json['playerTwoPhotoUrl'] as String,
      leagueId: (json['leagueId'] as num).toInt(),
      startTime: json['startTime'] == null
          ? null
          : DateTime.parse(json['startTime'] as String),
      endTime: json['endTime'] == null
          ? null
          : DateTime.parse(json['endTime'] as String),
      playerOneScore: (json['playerOneScore'] as num?)?.toInt(),
      playerTwoScore: (json['playerTwoScore'] as num?)?.toInt(),
      matchStarted: json['matchStarted'] as bool?,
      matchEnded: json['matchEnded'] as bool?,
      matchPaused: json['matchPaused'] as bool?,
      totalPlayingTime: json['totalPlayingTime'] as String?,
    );

Map<String, dynamic> _$SingleLeagueMatchModelToJson(
        SingleLeagueMatchModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'playerOne': instance.playerOne,
      'playerOneFirstName': instance.playerOneFirstName,
      'playerOneLastName': instance.playerOneLastName,
      'playerOnePhotoUrl': instance.playerOnePhotoUrl,
      'playerTwo': instance.playerTwo,
      'playerTwoFirstName': instance.playerTwoFirstName,
      'playerTwoLastName': instance.playerTwoLastName,
      'playerTwoPhotoUrl': instance.playerTwoPhotoUrl,
      'leagueId': instance.leagueId,
      'startTime': instance.startTime?.toIso8601String(),
      'endTime': instance.endTime?.toIso8601String(),
      'playerOneScore': instance.playerOneScore,
      'playerTwoScore': instance.playerTwoScore,
      'matchStarted': instance.matchStarted,
      'matchEnded': instance.matchEnded,
      'matchPaused': instance.matchPaused,
      'totalPlayingTime': instance.totalPlayingTime,
    };
