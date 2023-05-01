import 'package:json_annotation/json_annotation.dart';

part 'user_last_ten.g.dart';

@JsonSerializable()
class UserLastTen {
  final int typeOfMatch;
  final String typeOfMatchName;
  final int userId;
  final int? teamMateId;
  final int matchId;
  final int opponentId;
  final int? opponentTwoId;
  final String opponentOneFirstName;
  final String opponentOneLastName;
  final String? opponentTwoFirstName;
  final String? opponentTwoLastName;
  final int userScore;
  final int opponentUserOrTeamScore;
  final DateTime dateOfGame;
  final int? leagueId;

  UserLastTen(
      {required this.typeOfMatch,
      required this.typeOfMatchName,
      required this.userId,
      required this.teamMateId,
      required this.matchId,
      required this.opponentId,
      required this.opponentTwoId,
      required this.opponentOneFirstName,
      required this.opponentOneLastName,
      required this.opponentTwoFirstName,
      required this.opponentTwoLastName,
      required this.userScore,
      required this.opponentUserOrTeamScore,
      required this.dateOfGame,
      required this.leagueId});

  factory UserLastTen.fromJson(Map<String, dynamic> item) =>
      _$UserLastTenFromJson(item);

  Map<String, dynamic> toJson(item) => _$UserLastTenToJson(item);
}
