import 'package:json_annotation/json_annotation.dart';

part 'historyModel.g.dart';

@JsonSerializable()
class HistoryModel {
  final int typeOfMatch;
  final String typeOfMatchName;
  final int userId;
  final int? teamMateId;
  final String? teamMateFirstName;
  final String? teamMateLastName;
  final String? teamMatePhotoUrl;
  final int matchId;
  final int opponentId;
  final int? opponentTwoId;
  final String opponentOneFirstName;
  final String opponentOneLastName;
  final String opponentOnePhotoUrl;
  final String? opponentTwoFirstName; 
  final String? opponentTwoLastName;
  final String? opponentTwoPhotoUrl;
  final int userScore;
  final int opponentUserOrTeamScore;
  final DateTime dateOfGame;

  HistoryModel(
      {
      required this.typeOfMatch,
      required this.typeOfMatchName,
      required this.userId,
      required this.teamMateId,
      required this.teamMateFirstName,
      required this.teamMateLastName,
      required this.teamMatePhotoUrl,
      required this.matchId,
      required this.opponentId,
      required this.opponentTwoId,
      required this.opponentOneFirstName,
      required this.opponentOneLastName,
      required this.opponentOnePhotoUrl,
      required this.opponentTwoFirstName,
      required this.opponentTwoLastName,
      required this.opponentTwoPhotoUrl,
      required this.userScore,
      required this.opponentUserOrTeamScore,
      required this.dateOfGame});

  factory HistoryModel.fromJson(Map<String, dynamic> item) =>
      _$HistoryModelFromJson(item);

  Map<String, dynamic> toJson(item) => _$HistoryModelToJson(item);
}