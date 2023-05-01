import 'package:flutter/material.dart';
import 'package:foosball_mobile_app/api/FreehandGoalsApi.dart';
import 'package:foosball_mobile_app/api/FreehandMatchApi.dart';
import 'package:foosball_mobile_app/models/freehand-goals/freehand_goals_model.dart';
import 'package:foosball_mobile_app/models/freehand-matches/freehand_match_model.dart';
import 'package:foosball_mobile_app/models/other/freehandMatchDetailObject.dart';
import 'package:foosball_mobile_app/utils/helpers.dart';
import 'package:foosball_mobile_app/widgets/freehand_history/freehand_match_goals.dart';
import 'package:foosball_mobile_app/widgets/loading.dart';
import '../dashboard/Dashboard.dart';
import '../extended_Text.dart';
import '../match_score.dart';
import '../total_playing_time.dart';
import 'match_detail_buttons.dart';
import 'match_detail_card.dart';

class MatchDetails extends StatefulWidget {
  final FreehandMatchDetailObject freehandMatchDetailObject;

  const MatchDetails({Key? key, required this.freehandMatchDetailObject})
      : super(key: key);

  @override
  State<MatchDetails> createState() => _MatchDetailsState();
}

class _MatchDetailsState extends State<MatchDetails> {
  late Future<List<FreehandGoalsModel>?> goalsFuture;
  late Future<FreehandMatchModel?> matchFuture;
  Helpers helpers = Helpers();

  @override
  void initState() {
    super.initState();
    goalsFuture = getFreehandGoals(
        widget.freehandMatchDetailObject.freehandMatchCreateResponse!.id);
    matchFuture = getFreehandMatch(
        widget.freehandMatchDetailObject.freehandMatchCreateResponse!.id);
  }

  Future<List<FreehandGoalsModel>?> getFreehandGoals(int matchId) async {
    FreehandGoalsApi freehandGoalsApi = FreehandGoalsApi();
    var freehandGoals = await freehandGoalsApi.getFreehandGoals(matchId);
    return freehandGoals;
  }

  Future<FreehandMatchModel?> getFreehandMatch(int matchId) async {
    FreehandMatchApi freehandMatchApi = FreehandMatchApi();
    var freehandMatch = await freehandMatchApi.getFreehandMatch(matchId);
    return freehandMatch;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: ExtendedText(
              text: widget.freehandMatchDetailObject.userState.hardcodedStrings
                  .matchReport,
              userState: widget.freehandMatchDetailObject.userState),
          leading: IconButton(
            icon: const Icon(Icons.close),
            onPressed: () {
              // push to dashboard screen
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Dashboard(
                            param: widget.freehandMatchDetailObject.userState,
                          )));
            },
          ),
          iconTheme: helpers.getIconTheme(
              widget.freehandMatchDetailObject.userState.darkmode),
          backgroundColor: helpers.getBackgroundColor(
              widget.freehandMatchDetailObject.userState.darkmode)),
      body: FutureBuilder(
        future: Future.wait([goalsFuture, matchFuture]),
        builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
          if (snapshot.hasData) {
            var goals =
                snapshot.data![0] as List<FreehandGoalsModel>?; //freehand goals
            var match = snapshot.data![1] as FreehandMatchModel;

            String totalPlayingTime = '';
            if (match.totalPlayingTime != null) {
              totalPlayingTime = match.totalPlayingTime!;
            }
            String userScore = '';
            String opponentScore = '';
            if (match.playerOneId ==
                widget.freehandMatchDetailObject.playerOne.id) {
              userScore = match.playerOneScore.toString();
              opponentScore = match.playerTwoScore.toString();
            } else {
              userScore = match.playerTwoScore.toString();
              opponentScore = match.playerOneScore.toString();
            }

            return Container(
              color: helpers.getBackgroundColor(
                  widget.freehandMatchDetailObject.userState.darkmode),
              child: Column(
                children: [
                  Row(
                    // align to center
                    children: [
                      MatchDetailCard(
                        match: match,
                        isPlayerOne: true,
                        userState: widget.freehandMatchDetailObject.userState,
                      ),
                      MatchDetailCard(
                        match: match,
                        isPlayerOne: false,
                        userState: widget.freehandMatchDetailObject.userState,
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      MatchScore(
                        userState: widget.freehandMatchDetailObject.userState,
                        userScore: userScore,
                      ),
                      MatchScore(
                        userState: widget.freehandMatchDetailObject.userState,
                        userScore: opponentScore,
                      ),
                    ],
                  ),
                  TotalPlayingTime(
                    userState: widget.freehandMatchDetailObject.userState,
                    totalPlayingTime: totalPlayingTime,
                    totalPlayingTimeLabel: widget.freehandMatchDetailObject
                        .userState.hardcodedStrings.totalPlayingTime,
                  ),
                  FreehandMatchGoals(
                    userState: widget.freehandMatchDetailObject.userState,
                    freehandGoals: goals,
                  ),
                  const Spacer(),
                  MatchDetailButtons(
                      userState: widget.freehandMatchDetailObject.userState,
                      freehandMatchDetailObject:
                          widget.freehandMatchDetailObject),
                ],
              ),
            );
          } else {
            return Center(
                child: Loading(
                    userState: widget.freehandMatchDetailObject.userState));
          }
        },
      ),
    );
  }
}
