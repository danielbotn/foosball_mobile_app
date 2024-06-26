import 'package:flutter/material.dart';
import 'package:foosball_mobile_app/api/SingleLeagueGoalApi.dart';
import 'package:foosball_mobile_app/api/SingleLeagueMatchApi.dart';
import 'package:foosball_mobile_app/models/single-league-goals/single_league_goal_model.dart';
import 'package:foosball_mobile_app/models/single-league-matches/single_league_match_model.dart';
import 'package:foosball_mobile_app/state/user_state.dart';
import 'package:foosball_mobile_app/utils/helpers.dart';
import 'package:foosball_mobile_app/widgets/UI/Error/ServerError.dart';
import 'package:foosball_mobile_app/widgets/extended_Text.dart';
import 'package:foosball_mobile_app/widgets/league/ongoing_game/match_details/match_detail_buttons/match_detail_buttons.dart';
import 'package:foosball_mobile_app/widgets/league/ongoing_game/match_details/match_detail_card/MatchDetailCard.dart';
import 'package:foosball_mobile_app/widgets/league/ongoing_game/match_details/match_goals/match_goals.dart';
import 'package:foosball_mobile_app/widgets/league/ongoing_game/match_details/match_score/match_score.dart';
import 'package:foosball_mobile_app/widgets/league/ongoing_game/match_details/total_playing_time/total_playing_time.dart';
import 'package:foosball_mobile_app/widgets/loading.dart';
import 'package:foosball_mobile_app/widgets/dashboard/New_Dashboard.dart';

class MatchDetails extends StatefulWidget {
  final UserState userState;
  final SingleLeagueMatchModel? matchModel;
  const MatchDetails(
      {super.key, required this.userState, required this.matchModel});

  @override
  State<MatchDetails> createState() => _MatchDetailsState();
}

class _MatchDetailsState extends State<MatchDetails> {
  late Future<List<SingleLeagueGoalModel>?> goalsFuture;
  late Future<SingleLeagueMatchModel?> matchFuture;

  @override
  void initState() {
    super.initState();
    goalsFuture = getGoals(widget.matchModel!.id, widget.matchModel!.leagueId);
    matchFuture = getMatch(widget.matchModel!.id);
  }

  Future<List<SingleLeagueGoalModel>?> getGoals(
      int matchId, int leagueId) async {
    SingleLeagueGoalApi api = SingleLeagueGoalApi();
    var freehandGoals = await api.getSingleLeagueGoals(leagueId, matchId);
    return freehandGoals;
  }

  Future<SingleLeagueMatchModel?> getMatch(int matchId) async {
    SingleLeagueMatchApi api = SingleLeagueMatchApi();
    var freehandMatch = await api.getSingleLeagueMatchById(matchId);
    return freehandMatch;
  }

  @override
  Widget build(BuildContext context) {
    Helpers helpers = Helpers();
    return Scaffold(
      appBar: AppBar(
          title: ExtendedText(
              text: widget.userState.hardcodedStrings.matchReport,
              userState: widget.userState),
          leading: IconButton(
            icon: const Icon(Icons.close),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => NewDashboard(
                            userState: widget.userState,
                          )));
            },
          ),
          iconTheme: helpers.getIconTheme(widget.userState.darkmode),
          backgroundColor:
              helpers.getBackgroundColor(widget.userState.darkmode)),
      body: FutureBuilder(
        future: Future.wait([goalsFuture, matchFuture]),
        builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Loading(
              userState: widget.userState,
            );
          }
          if (snapshot.hasData) {
            var goals = snapshot.data![0]
                as List<SingleLeagueGoalModel>?; //freehand goals
            var match = snapshot.data![1] as SingleLeagueMatchModel;

            String totalPlayingTime = '';
            if (match.totalPlayingTime != null) {
              totalPlayingTime = match.totalPlayingTime!;
            }
            int? userScore = match.playerOneScore;
            int? opponentScore = match.playerTwoScore;

            return Container(
              color: helpers.getBackgroundColor(widget.userState.darkmode),
              child: Column(
                children: [
                  Row(
                    // align to center
                    children: [
                      MatchDetailCard(
                        match: match,
                        isPlayerOne: true,
                        userState: widget.userState,
                      ),
                      MatchDetailCard(
                        match: match,
                        isPlayerOne: false,
                        userState: widget.userState,
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      MatchScore(
                        userState: widget.userState,
                        userScore: userScore.toString(),
                      ),
                      MatchScore(
                        userState: widget.userState,
                        userScore: opponentScore.toString(),
                      ),
                    ],
                  ),
                  TotalPlayingTime(
                    userState: widget.userState,
                    totalPlayingTime: totalPlayingTime,
                    totalPlayingTimeLabel:
                        widget.userState.hardcodedStrings.totalPlayingTime,
                  ),
                  Expanded(
                    child: MatchGoals(
                      userState: widget.userState,
                      goals: goals,
                    ),
                  ),
                  MatchDetailButtons(userState: widget.userState)
                ],
              ),
            );
          } else if (snapshot.hasError) {
            return ServerError(userState: widget.userState);
          } else {
            return const Text('No data found');
          }
        },
      ),
    );
  }
}
