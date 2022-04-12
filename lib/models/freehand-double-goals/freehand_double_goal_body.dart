class FreehandDoubleGoalBody {
  int doubleMatchId;
  int scoredByUserId;
  int scorerTeamScore;
  int opponentTeamScore;
  bool winnerGoal;
  FreehandDoubleGoalBody({
    required this.doubleMatchId,
    required this.scoredByUserId,
    required this.scorerTeamScore,
    required this.opponentTeamScore,
    required this.winnerGoal,
  });
}
