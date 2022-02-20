import 'package:json_annotation/json_annotation.dart';

part 'freehand_match_model.g.dart';

@JsonSerializable()
class FreehandMatchModel {
  final int id;
  final int playerOneId;
  final String playerOneFirstName;
  final String playerOneLastName;
  final String playerOnePhotoUrl;
  final int playerTwoId;
  final String playerTwoFirstName;
  final String playerTwoLastName;
  final String playerTwoPhotoUrl;
  final DateTime startTime;
  final DateTime endTime;
  final int playerOneScore;
  final int playerTwoScore;
  final int upTo;
  final bool gameFinished;
  final bool gamePaused;

  FreehandMatchModel(
      {required this.id,
      required this.playerOneId,
      required this.playerOneFirstName,
      required this.playerOneLastName,
      required this.playerOnePhotoUrl,
      required this.playerTwoId,
      required this.playerTwoFirstName,
      required this.playerTwoLastName,
      required this.playerTwoPhotoUrl,
      required this.startTime,
      required this.endTime,
      required this.playerOneScore,
      required this.playerTwoScore,
      required this.upTo,
      required this.gameFinished,
      required this.gamePaused
      });

  factory FreehandMatchModel.fromJson(Map<String, dynamic> item) =>
      _$FreehandMatchModelFromJson(item);

  Map<String, dynamic> toJson(item) => _$FreehandMatchModelToJson(item);
}
