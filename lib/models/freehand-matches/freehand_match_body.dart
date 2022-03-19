class FreehandMatchBody {
  int playerOneId;
  int playerTwoId;
  int playerOneScore;
  int playerTwoScore;
  int upTo;
  bool gameFinished;
  bool gamePaused;

  FreehandMatchBody(
      {required this.playerOneId,
      required this.playerTwoId,
      required this.playerOneScore,
      required this.playerTwoScore,
      required this.upTo,
      required this.gameFinished,
      required this.gamePaused});
}
