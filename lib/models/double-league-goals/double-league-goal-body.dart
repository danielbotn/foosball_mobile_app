import 'dart:core';

class DoubleLeagueGoalBody {
  DateTime timeOfGoal;
  int matchId;
  int scoredByTeamId;
  int opponentTeamId;
  int scorerTeamScore;
  int opponentTeamScore;
  bool winnerGoal;
  int userScorerId;

  DoubleLeagueGoalBody(
      {required this.timeOfGoal,
      required this.matchId,
      required this.scoredByTeamId,
      required this.opponentTeamId,
      required this.scorerTeamScore,
      required this.opponentTeamScore,
      required this.winnerGoal,
      required this.userScorerId});
}
