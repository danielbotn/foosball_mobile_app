import 'package:json_annotation/json_annotation.dart';

part 'freehand_double_match_model.g.dart';

@JsonSerializable()
class FreehandDoubleMatchModel {
  final int id;
  final int playerOneTeamA;
  final String playerOneTeamAFirstName;
  final String playerOneTeamALastName;
  final String playerOneTeamAPhotoUrl;
  final int playerTwoTeamA;
  final String playerTwoTeamAFirstName;
  final String playerTwoTeamALastName;
  final String playerTwoTeamAPhotoUrl;
  final int playerOneTeamB;
  final String playerOneTeamBFirstName;
  final String playerOneTeamBLastName;
  final String playerOneTeamBPhotoUrl;
  final int? playerTwoTeamB;
  final String? playerTwoTeamBFirstName;
  final String? playerTwoTeamBLastName;
  final String? playerTwoTeamBPhotoUrl;
  final int organisationId;
  final DateTime startTime;
  final DateTime endTime;
  final String totalPlayingTime;
  final int teamAScore;
  final int teamBScore;
  final String nicknameTeamA;
  final String nicknameTeamB;
  final int upTo;
  final bool gameFinished;
  final bool gamePaused;
  
  

  FreehandDoubleMatchModel(
      {required this.id,
      required this.playerOneTeamA,
      required this.playerOneTeamAFirstName,
      required this.playerOneTeamALastName,
      required this.playerOneTeamAPhotoUrl,
      required this.playerTwoTeamA,
      required this.playerTwoTeamAFirstName,
      required this.playerTwoTeamALastName,
      required this.playerTwoTeamAPhotoUrl,
      required this.playerOneTeamB,
      required this.playerOneTeamBFirstName,
      required this.playerOneTeamBLastName,
      required this.playerOneTeamBPhotoUrl,
      required this.playerTwoTeamB,
      required this.playerTwoTeamBFirstName,
      required this.playerTwoTeamBLastName,
      required this.playerTwoTeamBPhotoUrl,
      required this.organisationId,
      required this.startTime,
      required this.endTime,
      required this.totalPlayingTime,
      required this.teamAScore,
      required this.teamBScore,
      required this.nicknameTeamA,
      required this.nicknameTeamB,
      required this.upTo,
      required this.gameFinished,
      required this.gamePaused
      });

  factory FreehandDoubleMatchModel.fromJson(Map<String, dynamic> item) =>
      _$FreehandDoubleMatchModelFromJson(item);

  Map<String, dynamic> toJson(item) => _$FreehandDoubleMatchModelToJson(item);
}
