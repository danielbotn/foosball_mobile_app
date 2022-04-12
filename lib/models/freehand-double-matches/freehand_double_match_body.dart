class FreehandDoubleMatchBody {
  int playerOneTeamA;
  int playerTwoTeamA;
  int playerOneTeamB;
  int? playerTwoTeamB;
  int organisationId;
  int teamAScore;
  int teamBScore;
  String? nicknameTeamA;
  String? nicknameTeamB;
  int upTo;

  FreehandDoubleMatchBody(
      {required this.playerOneTeamA,
      required this.playerTwoTeamA,
      required this.playerOneTeamB,
      required this.playerTwoTeamB,
      required this.organisationId,
      required this.teamAScore,
      required this.teamBScore,
      this.nicknameTeamA,
      this.nicknameTeamB,
      required this.upTo});
}
