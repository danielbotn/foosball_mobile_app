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
import '../extended_Text.dart';
import '../match_card.dart';
import '../match_score.dart';
import '../total_playing_time.dart';
import 'double_league_buttons.dart';
import 'double_league_goals.dart';

class DoubleLeagueMatchDetail extends StatefulWidget {
  // props
  final TwoPlayersObject twoPlayersObject;
  DoubleLeagueMatchDetail({
    Key? key,
    required this.twoPlayersObject,
  }) : super(key: key);

  @override
  _DoubleLeagueMatchDetailState createState() =>
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

    goalsFuture = getFreehandDoubleGoals();
    userFuture = getUser();
    matchFuture = getFreehandDoubleMatch();
  }

  Future<List<DoubleLeagueGoalModel>?> getFreehandDoubleGoals() async {
    DoubleLeagueGoalsApi fgapi = new DoubleLeagueGoalsApi(
        token: this.widget.twoPlayersObject.userState.token);
    var freehandGoals =
        await fgapi.getDoubleLeagueGoals(this.widget.twoPlayersObject.matchId);
    return freehandGoals;
  }

  Future<UserResponse> getUser() async {
    UserApi uapi =
        new UserApi(token: this.widget.twoPlayersObject.userState.token);
    var user = await uapi
        .getUser(this.widget.twoPlayersObject.userState.userId.toString());
    return user;
  }

  Future<DoubleLeagueMatchModel?> getFreehandDoubleMatch() async {
    DoubleLeagueMatchApi fmapi = new DoubleLeagueMatchApi(
        token: this.widget.twoPlayersObject.userState.token);
    var freehandMatch =
        await fmapi.getDoubleLeagueMatch(this.widget.twoPlayersObject.matchId);
    return freehandMatch;
  }

  @override
  Widget build(BuildContext context) {
    String matchDetails =
        this.widget.twoPlayersObject.userState.hardcodedStrings.matchDetails;
    Helpers helpers = Helpers();
    return Scaffold(
      appBar: AppBar(
          title: ExtendedText(text: matchDetails, userState: userState),
          leading: IconButton(
            icon: Icon(Icons.chevron_left),
            onPressed: () {
              Navigator.pop(context);
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
            var userInfo = snapshot.data![1] as UserResponse; //user info
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
                          userState: this.widget.twoPlayersObject.userState,
                          userFirstName: teamOne[0].firstName,
                          userLastName: teamOne[0].lastName,
                          userPhotoUrl: teamOne[0].photoUrl,
                          lefOrRight: true,
                          widthAndHeight: 60,
                        ),
                        MatchCard(
                          userState: this.widget.twoPlayersObject.userState,
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
                          userState: this.widget.twoPlayersObject.userState,
                          userFirstName: teamOne[1].firstName,
                          userLastName: teamOne[1].lastName,
                          userPhotoUrl: teamOne[1].photoUrl,
                          lefOrRight: true,
                          widthAndHeight: 60,
                        ),
                        Visibility(
                          visible: match.teamTwo.length > 1,
                          child: MatchCard(
                            userState: this.widget.twoPlayersObject.userState,
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
                          userState: this.widget.twoPlayersObject.userState,
                          userScore: match.teamOneScore.toString(),
                        ),
                        MatchScore(
                          userState: this.widget.twoPlayersObject.userState,
                          userScore: match.teamTwoScore.toString(),
                        ),
                      ],
                    ),
                    TotalPlayingTime(
                        userState: this.widget.twoPlayersObject.userState,
                        totalPlayingTime: match.totalPlayingTime != null
                            ? match.totalPlayingTime.toString()
                            : "",
                        totalPlayingTimeLabel: this
                            .widget
                            .twoPlayersObject
                            .userState
                            .hardcodedStrings
                            .totalPlayingTime),
                    DoubleLeagueGoals(
                      userState: this.widget.twoPlayersObject.userState,
                      goals: dlg,
                    ),
                    Spacer(),
                    DoubleLeagueButtons(
                        userState: this.widget.twoPlayersObject.userState)
                  ],
                ));
          } else {
            return CircularProgressIndicator();
          }
        },
      ),
    );
  }
}
