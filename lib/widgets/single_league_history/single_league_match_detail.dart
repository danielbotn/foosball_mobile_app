import 'package:flutter/material.dart';
import 'package:foosball_mobile_app/api/SingleLeagueGoalApi.dart';
import 'package:foosball_mobile_app/api/SingleLeagueMatchApi.dart';
import 'package:foosball_mobile_app/api/UserApi.dart';
import 'package:foosball_mobile_app/main.dart';
import 'package:foosball_mobile_app/models/other/TwoPlayersObject.dart';
import 'package:foosball_mobile_app/models/single-league-goals/single_league_goal_model.dart';
import 'package:foosball_mobile_app/models/single-league-matches/single_league_match_model.dart';
import 'package:foosball_mobile_app/models/user/user_response.dart';
import 'package:foosball_mobile_app/utils/helpers.dart';
import 'package:foosball_mobile_app/widgets/single_league_history/single_league_buttons.dart';
import 'package:foosball_mobile_app/widgets/single_league_history/single_league_goals.dart';
import 'package:foosball_mobile_app/widgets/total_playing_time.dart';
import 'package:foosball_mobile_app/widgets/match_score.dart';
import 'package:foosball_mobile_app/widgets/match_card.dart';

import '../extended_Text.dart';

class SingleLeagueMatchDetail extends StatefulWidget {
  // Props
  final TwoPlayersObject twoPlayersObject;
  SingleLeagueMatchDetail({Key? key, required this.twoPlayersObject})
      : super(key: key);

  @override
  State<SingleLeagueMatchDetail> createState() =>
      _SingleLeagueMatchDetailState();
}

class _SingleLeagueMatchDetailState extends State<SingleLeagueMatchDetail> {
  late Future<UserResponse> userFuture;
  late Future<SingleLeagueMatchModel?> singleLeagueMatchFuture;
  late Future<List<SingleLeagueGoalModel>?> singleLeagueGoalsFuture;

  SingleLeagueMatchModel? singleLeagueMatch;

  @override
  void initState() {
    super.initState();

    userFuture = getUser();
    singleLeagueMatchFuture = getSingleLeagueMatch();
    singleLeagueGoalsFuture = getSingleLeagueGoals();
  }

  Future<UserResponse> getUser() async {
    UserApi uapi =
        new UserApi(token: this.widget.twoPlayersObject.userState.token);
    var user = await uapi
        .getUser(this.widget.twoPlayersObject.userState.userId.toString());
    return user;
  }

  Future<SingleLeagueMatchModel?> getSingleLeagueMatch() async {
    SingleLeagueMatchApi api = new SingleLeagueMatchApi(
        token: this.widget.twoPlayersObject.userState.token);
    var match = await api
        .getSingleLeagueMatchById(this.widget.twoPlayersObject.matchId);
    setState(() {
      singleLeagueMatch = match;
    });
    return match;
  }

  Future<List<SingleLeagueGoalModel>?> getSingleLeagueGoals() async {
    SingleLeagueGoalApi api = new SingleLeagueGoalApi(token: this.widget.twoPlayersObject.userState.token);
    int leagueId = 0;
    if (this.widget.twoPlayersObject.leagueId != null) {
      leagueId = this.widget.twoPlayersObject.leagueId!;
    }
    List<SingleLeagueGoalModel>? goals = await api.getSingleLeagueGoals(leagueId, this.widget.twoPlayersObject.matchId);
    
    return goals;
  }

  @override
  Widget build(BuildContext context) {
    Helpers helper = new Helpers();
    String matchDetails =
        this.widget.twoPlayersObject.userState.hardcodedStrings.matchDetails;
    return Scaffold(
      appBar: AppBar(
          title: ExtendedText(text: matchDetails, userState: userState),
          leading: IconButton(
            icon: Icon(Icons.chevron_left),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          iconTheme: helper.getIconTheme(userState.darkmode),
          backgroundColor: helper.getBackgroundColor(userState.darkmode)),
      body: FutureBuilder(
          future: Future.wait(
              [userFuture, singleLeagueMatchFuture, singleLeagueGoalsFuture]),
          builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
            if (snapshot.hasData) {
              var userInfo = snapshot.data![0] as UserResponse;
              var match = snapshot.data![1] as SingleLeagueMatchModel;
              var goals = snapshot.data![2] as List<SingleLeagueGoalModel?>;

              String opponentFirstName,
                  opponentLastName,
                  opponentPhotoUrl,
                  userScore,
                  opponentScore,
                  totalPlayingTime;

              if (match.playerOne == userInfo.id) {
                opponentFirstName = match.playerTwoFirstName;
                opponentLastName = match.playerTwoLastName;
                opponentPhotoUrl = match.playerTwoPhotoUrl;
                userScore = match.playerOneScore.toString();
                opponentScore = match.playerTwoScore.toString();
              } else {
                opponentFirstName = match.playerOneFirstName;
                opponentLastName = match.playerOneLastName;
                opponentPhotoUrl = match.playerOnePhotoUrl;
                userScore = match.playerTwoScore.toString();
                opponentScore = match.playerOneScore.toString();
              }
              if (match.totalPlayingTime != null) {
                totalPlayingTime = match.totalPlayingTime!;
              } else {
                totalPlayingTime = "";
              }
              return Container(
                  color: helper.getBackgroundColor(userState.darkmode),
                  child: Column(children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        MatchCard(
                          userState: this.widget.twoPlayersObject.userState,
                          userFirstName: userInfo.firstName,
                          userLastName: userInfo.lastName,
                          userPhotoUrl: userInfo.photoUrl,
                          lefOrRight: true,
                        ),
                        MatchCard(
                          userState: this.widget.twoPlayersObject.userState,
                          userFirstName: opponentFirstName,
                          userLastName: opponentLastName,
                          userPhotoUrl: opponentPhotoUrl,
                          lefOrRight: false,
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        MatchScore(
                          userState: this.widget.twoPlayersObject.userState,
                          userScore: userScore,
                        ),
                        MatchScore(
                          userState: this.widget.twoPlayersObject.userState,
                          userScore: opponentScore,
                        ),
                      ],
                    ),
                    TotalPlayingTime(
                      userState: this.widget.twoPlayersObject.userState,
                      totalPlayingTime: totalPlayingTime,
                      totalPlayingTimeLabel: this
                          .widget
                          .twoPlayersObject
                          .userState
                          .hardcodedStrings
                          .totalPlayingTime,
                    ),
                    SingleLeagueGoals(
                      userState: this.widget.twoPlayersObject.userState,
                      singleLeagueGoals: goals,
                    ),
                    Spacer(),
                    SingleLeagueButtons(userState: userState)
                  ]));
            } else {
              return Center(child: CircularProgressIndicator());
            }
          }),
    );
  }
}
