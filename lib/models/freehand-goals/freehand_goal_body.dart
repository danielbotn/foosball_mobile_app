class FreehandGoalBody {
  int matchId;
  int scoredByUserId;
  int oponentId;
  int scoredByScore;
  int oponentScore;
  bool winnerGoal;
  FreehandGoalBody({
    required this.matchId,
    required this.scoredByUserId,
    required this.oponentId,
    required this.scoredByScore,
    required this.oponentScore,
    required this.winnerGoal,
  });
}
