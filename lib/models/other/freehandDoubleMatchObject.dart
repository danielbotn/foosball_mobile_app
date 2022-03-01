class FreehandDoubleMatchObject {
  String teamMateFirstName;
  String teamMateLastName;
  String teamMatePhotoUrl;
  String opponentOneFirstName;
  String opponentOneLastName;
  String opponentOnePhotoUrl;
  String? opponentTwoFirstName;
  String? opponentTwoLastName;
  String? opponentTwoPhotoUrl;
  String userScore;
  String opponentScore;

  FreehandDoubleMatchObject({
    required this.teamMateFirstName,
    required this.teamMateLastName,
    required this.teamMatePhotoUrl,
    required this.opponentOneFirstName,
    required this.opponentOneLastName,
    required this.opponentOnePhotoUrl,
    this.opponentTwoFirstName,
    this.opponentTwoLastName,
    this.opponentTwoPhotoUrl,
    required this.userScore,
    required this.opponentScore,
  });

}