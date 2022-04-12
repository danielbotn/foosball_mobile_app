import 'package:json_annotation/json_annotation.dart';

part 'freehand_double_match_create_response.g.dart';


@JsonSerializable()
class FreehandDoubleMatchCreateResponse {
  final int id;
  final int playerOneTeamA;
  final int playerOneTeamB;
  final int playerTwoTeamA;
  final int playerTwoTeamB;
  final DateTime startTime;
  final DateTime? endTime;
  final int upTo;
  final bool gameFinished;
  final bool gamePaused;
  final int organisationId;
  String? nicknameTeamA;
  String? nicknameTeamB;

  FreehandDoubleMatchCreateResponse(
      {
        required this.id,
        required this.playerOneTeamA,
        required this.playerOneTeamB,
        required this.playerTwoTeamA,
        required this.playerTwoTeamB,
        required this.startTime,
        required this.endTime,
        required this.upTo,
        required this.gameFinished,
        required this.gamePaused,
        required this.organisationId,
        this.nicknameTeamA,
        this.nicknameTeamB,
      });

  factory FreehandDoubleMatchCreateResponse.fromJson(Map<String, dynamic> item) =>
      _$FreehandDoubleMatchCreateResponseFromJson(item);

  Map<String, dynamic> toJson(item) => _$FreehandDoubleMatchCreateResponseToJson(item);
}
