import 'package:flutter/material.dart';
import 'package:dano_foosball/api/FreehandDoubleGoalsApi.dart';
import 'package:dano_foosball/api/FreehandDoubleMatchApi.dart';
import 'package:dano_foosball/main.dart';
import 'package:dano_foosball/models/freehand-double-goals/freehand_double_goal_model.dart';
import 'package:dano_foosball/models/freehand-double-matches/freehand_double_match_model.dart';
import 'package:dano_foosball/models/other/freehandDoubleMatchDetailObject.dart';
import 'package:dano_foosball/utils/helpers.dart';
import 'package:dano_foosball/widgets/extended_Text.dart';
import 'package:dano_foosball/widgets/freehand_double_history/freehand_double_goals.dart';
import 'package:dano_foosball/widgets/loading.dart';
import 'package:dano_foosball/widgets/match_score.dart';
import 'package:dano_foosball/widgets/ongoing_double_freehand_game/match_detail_card.dart';
import 'package:dano_foosball/widgets/ongoing_double_freehand_game/match_details_buttons.dart';

import '../total_playing_time.dart';

class MatchDetails extends StatefulWidget {
  final FreehandDoubleMatchDetailObject data;
  const MatchDetails({Key? key, required this.data}) : super(key: key);

  @override
  State<MatchDetails> createState() => _MatchDetailsState();
}

class _MatchDetailsState extends State<MatchDetails> {
  late Future<List<FreehandDoubleGoalModel>?> goalsFuture;
  late Future<FreehandDoubleMatchModel?> matchFuture;
  Helpers helpers = Helpers();

  @override
  void initState() {
    super.initState();
    goalsFuture = getFreehandGoals(widget.data.freehandMatchCreateResponse!.id);
    matchFuture = getFreehandMatch(widget.data.freehandMatchCreateResponse!.id);
  }

  Future<List<FreehandDoubleGoalModel>?> getFreehandGoals(int matchId) async {
    FreehandDoubleGoalsApi freehandGoalsApi = FreehandDoubleGoalsApi();
    var freehandGoals = await freehandGoalsApi.getFreehandDoubleGoals(matchId);
    return freehandGoals;
  }

  Future<FreehandDoubleMatchModel?> getFreehandMatch(int matchId) async {
    FreehandDoubleMatchApi freehandMatchApi = FreehandDoubleMatchApi();
    var freehandMatch = await freehandMatchApi.getDoubleFreehandMatch(matchId);
    return freehandMatch;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: ExtendedText(
            text: widget.data.userState.hardcodedStrings.matchReport,
            userState: widget.data.userState),
        leading: IconButton(
          icon: const Icon(Icons.chevron_left),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        iconTheme: helpers.getIconTheme(widget.data.userState.darkmode),
        backgroundColor:
            helpers.getBackgroundColor(widget.data.userState.darkmode),
      ),
      body: FutureBuilder(
        future: Future.wait([goalsFuture, matchFuture]),
        builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
          if (snapshot.hasData) {
            var goals = snapshot.data![0]
                as List<FreehandDoubleGoalModel>?; //freehand goals
            var match = snapshot.data![1] as FreehandDoubleMatchModel;
            return Container(
              color: helpers.getBackgroundColor(widget.data.userState.darkmode),
              child: Column(
                children: [
                  Row(
                    children: [
                      MatchDetailCard(
                        match: match,
                        player: widget.data.teamOne.players[0],
                        userState: widget.data.userState,
                      ),
                      MatchDetailCard(
                        match: match,
                        player: widget.data.teamTwo.players[0],
                        userState: widget.data.userState,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      MatchDetailCard(
                        match: match,
                        player: widget.data.teamOne.players[1],
                        userState: widget.data.userState,
                      ),
                      MatchDetailCard(
                        match: match,
                        player: widget.data.teamTwo.players[1],
                        userState: widget.data.userState,
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      MatchScore(
                        userState: widget.data.userState,
                        userScore: widget.data.teamOne.score.toString(),
                      ),
                      MatchScore(
                        userState: widget.data.userState,
                        userScore: widget.data.teamTwo.score.toString(),
                      ),
                    ],
                  ),
                  TotalPlayingTime(
                    userState: widget.data.userState,
                    totalPlayingTime: match.totalPlayingTime,
                    totalPlayingTimeLabel:
                        widget.data.userState.hardcodedStrings.totalPlayingTime,
                  ),
                  Expanded(
                    child: FreehandDoubleGoals(
                      userState: widget.data.userState,
                      freehandGoals: goals,
                    ),
                  ),
                  MatchDetailButtons(
                      data: widget.data, userState: widget.data.userState)
                ],
              ),
            );
          } else {
            return Center(
              child: Loading(userState: userState),
            );
          }
        },
      ),
    );
  }
}
