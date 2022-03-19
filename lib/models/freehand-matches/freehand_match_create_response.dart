import 'package:json_annotation/json_annotation.dart';

part 'freehand_match_create_response.g.dart';


@JsonSerializable()
class FreehandMatchCreateResponse {
  final int id;
  final int playerOneId;
  final int playerTwoId;
  final DateTime startTime;
  final DateTime? endTime;
  final int playerOneScore;
  final int playerTwoScore;
  final int upTo;
  final bool gameFinished;
  final bool gamePaused;
  final int organisationId;

  FreehandMatchCreateResponse(
      {required this.id,
      required this.playerOneId,
      required this.playerTwoId,
      required this.startTime,
      required this.endTime,
      required this.playerOneScore,
      required this.playerTwoScore,
      required this.upTo,
      required this.gameFinished,
      required this.gamePaused,
      required this.organisationId
      });

  factory FreehandMatchCreateResponse.fromJson(Map<String, dynamic> item) =>
      _$FreehandMatchCreateResponseFromJson(item);

  Map<String, dynamic> toJson(item) => _$FreehandMatchCreateResponseToJson(item);
}
