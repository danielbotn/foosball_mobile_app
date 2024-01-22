import 'package:flutter/material.dart';
import 'package:foosball_mobile_app/api/DoubleLeagueGoalsApi.dart';
import 'package:foosball_mobile_app/api/DoubleLeagueMatchApi.dart';
import 'package:foosball_mobile_app/api/UserApi.dart';
import 'package:foosball_mobile_app/main.dart';
import 'package:foosball_mobile_app/models/double-league-goals/double_league_goal_model.dart';
import 'package:foosball_mobile_app/models/double-league-matches/double_league_match_model.dart';
import 'package:foosball_mobile_app/models/other/TwoPlayersObject.dart';
import 'package:foosball_mobile_app/models/user/user_response.dart';
import 'package:foosball_mobile_app/utils/helpers.dart';
import 'package:foosball_mobile_app/widgets/dashboard/New_Dashboard.dart';
import 'package:foosball_mobile_app/widgets/loading.dart';
import '../extended_Text.dart';
import '../match_card.dart';
import '../match_score.dart';
import '../total_playing_time.dart';
import 'double_league_buttons.dart';
import 'double_league_goals.dart';

class DoubleLeagueMatchDetail extends StatefulWidget {
  // props
  final TwoPlayersObject twoPlayersObject;
  const DoubleLeagueMatchDetail({
    Key? key,
    required this.twoPlayersObject,
  }) : super(key: key);

  @override
  State<DoubleLeagueMatchDetail> createState() =>
      _DoubleLeagueMatchDetailState();
}

class _DoubleLeagueMatchDetailState extends State<DoubleLeagueMatchDetail> {
  // State variables
  late Future<List<DoubleLeagueGoalModel>?> goalsFuture;
  late Future<UserResponse> userFuture;
  late Future<DoubleLeagueMatchModel?> matchFuture;

  @override
  void initState() {
    super.initState();

    goalsFuture = gedDoubleLeagueGoals();
    userFuture = getUser();
    matchFuture = getDoubleLeaugeMatch();
  }

  Future<List<DoubleLeagueGoalModel>?> gedDoubleLeagueGoals() async {
    DoubleLeagueGoalsApi fgapi = DoubleLeagueGoalsApi();
    var freehandGoals =
        await fgapi.getDoubleLeagueGoals(widget.twoPlayersObject.matchId);
    return freehandGoals;
  }

  Future<UserResponse> getUser() async {
    UserApi uapi = UserApi();
    var user =
        await uapi.getUser(widget.twoPlayersObject.userState.userId.toString());
    return user;
  }

  Future<DoubleLeagueMatchModel?> getDoubleLeaugeMatch() async {
    DoubleLeagueMatchApi fmapi = DoubleLeagueMatchApi();
    var match =
        await fmapi.getDoubleLeagueMatch(widget.twoPlayersObject.matchId);
    return match;
  }

  @override
  Widget build(BuildContext context) {
    String matchDetails =
        widget.twoPlayersObject.userState.hardcodedStrings.matchDetails;
    Helpers helpers = Helpers();
    return Scaffold(
      appBar: AppBar(
          title: ExtendedText(text: matchDetails, userState: userState),
          leading: IconButton(
            icon: const Icon(Icons.close),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => NewDashboard(
                    userState: userState,
                  ),
                ),
              );
            },
          ),
          iconTheme: helpers.getIconTheme(userState.darkmode),
          backgroundColor: helpers.getBackgroundColor(userState.darkmode)),
      body: FutureBuilder(
        future: Future.wait([goalsFuture, userFuture, matchFuture]),
        builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
          if (snapshot.hasData) {
            var dlg = snapshot.data![0]
                as List<DoubleLeagueGoalModel>?; //freehand goals
            var match =
                snapshot.data![2] as DoubleLeagueMatchModel?; //freehand match

            var teamOne = match!.teamOne;
            var teamTwo = match.teamTwo;

            return Container(
                color: helpers.getBackgroundColor(userState.darkmode),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        MatchCard(
                          userState: widget.twoPlayersObject.userState,
                          userFirstName: teamOne[0].firstName,
                          userLastName: teamOne[0].lastName,
                          userPhotoUrl: teamOne[0].photoUrl,
                          lefOrRight: true,
                          widthAndHeight: 60,
                        ),
                        MatchCard(
                          userState: widget.twoPlayersObject.userState,
                          userFirstName: teamTwo[0].firstName,
                          userLastName: teamTwo[0].lastName,
                          userPhotoUrl: teamTwo[0].photoUrl,
                          lefOrRight: true,
                          widthAndHeight: 60,
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        MatchCard(
                          userState: widget.twoPlayersObject.userState,
                          userFirstName: teamOne[1].firstName,
                          userLastName: teamOne[1].lastName,
                          userPhotoUrl: teamOne[1].photoUrl,
                          lefOrRight: true,
                          widthAndHeight: 60,
                        ),
                        Visibility(
                          visible: match.teamTwo.length > 1,
                          child: MatchCard(
                            userState: widget.twoPlayersObject.userState,
                            userFirstName: teamTwo[1].firstName,
                            userLastName: teamTwo[1].lastName,
                            userPhotoUrl: teamTwo[1].photoUrl,
                            lefOrRight: true,
                            widthAndHeight: 60,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        MatchScore(
                          userState: widget.twoPlayersObject.userState,
                          userScore: match.teamOneScore.toString(),
                        ),
                        MatchScore(
                          userState: widget.twoPlayersObject.userState,
                          userScore: match.teamTwoScore.toString(),
                        ),
                      ],
                    ),
                    TotalPlayingTime(
                        userState: widget.twoPlayersObject.userState,
                        totalPlayingTime: match.totalPlayingTime != null
                            ? match.totalPlayingTime.toString()
                            : "",
                        totalPlayingTimeLabel: widget.twoPlayersObject.userState
                            .hardcodedStrings.totalPlayingTime),
                    DoubleLeagueGoals(
                      userState: widget.twoPlayersObject.userState,
                      goals: dlg,
                    ),
                    const Spacer(),
                    DoubleLeagueButtons(
                        userState: widget.twoPlayersObject.userState)
                  ],
                ));
          } else {
            return Loading(userState: userState);
          }
        },
      ),
    );
  }
}
