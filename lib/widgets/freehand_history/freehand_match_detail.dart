import 'package:flutter/material.dart';
import 'package:foosball_mobile_app/api/FreehandGoalsApi.dart';
import 'package:foosball_mobile_app/api/FreehandMatchApi.dart';
import 'package:foosball_mobile_app/api/UserApi.dart';
import 'package:foosball_mobile_app/main.dart';
import 'package:foosball_mobile_app/models/freehand-goals/freehand_goals_model.dart';
import 'package:foosball_mobile_app/models/freehand-matches/freehand_match_model.dart';
import 'package:foosball_mobile_app/models/other/TwoPlayersObject.dart';
import 'package:foosball_mobile_app/models/user/user_response.dart';
import 'package:foosball_mobile_app/utils/helpers.dart';
import '../extended_Text.dart';
import 'freehand_match_buttons.dart';
import '../match_card.dart';
import 'freehand_match_goals.dart';
import '../match_score.dart';
import '../total_playing_time.dart';

class FreehandMatchDetail extends StatefulWidget {
  // props
  final TwoPlayersObject twoPlayersObject;
  const FreehandMatchDetail({
    Key? key,
    required this.twoPlayersObject,
  }) : super(key: key);

  @override
  State<FreehandMatchDetail> createState() => _FreehandMatchDetailState();
}

class _FreehandMatchDetailState extends State<FreehandMatchDetail> {
  // State variables
  late Future<List<FreehandGoalsModel>?> freehandGoalsFuture;
  late Future<UserResponse> userFuture;
  late Future<FreehandMatchModel?> freehandMatchFuture;

  @override
  void initState() {
    super.initState();

    freehandGoalsFuture = getFreehandGoals();
    userFuture = getUser();
    freehandMatchFuture = getFreehandMatch();
  }

  Future<List<FreehandGoalsModel>?> getFreehandGoals() async {
    FreehandGoalsApi fgapi =
        FreehandGoalsApi(token: widget.twoPlayersObject.userState.token);
    var freehandGoals =
        await fgapi.getFreehandGoals(widget.twoPlayersObject.matchId);
    return freehandGoals;
  }

  Future<UserResponse> getUser() async {
    UserApi uapi = UserApi(token: widget.twoPlayersObject.userState.token);
    var user =
        await uapi.getUser(widget.twoPlayersObject.userState.userId.toString());
    return user;
  }

  Future<FreehandMatchModel?> getFreehandMatch() async {
    FreehandMatchApi fmapi =
        FreehandMatchApi(token: widget.twoPlayersObject.userState.token);
    var freehandMatch =
        await fmapi.getFreehandMatch(widget.twoPlayersObject.matchId);
    return freehandMatch;
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
            icon: const Icon(Icons.chevron_left),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          iconTheme: helpers.getIconTheme(userState.darkmode),
          backgroundColor: helpers.getBackgroundColor(userState.darkmode)),
      body: FutureBuilder(
        future:
            Future.wait([freehandGoalsFuture, userFuture, freehandMatchFuture]),
        builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
          if (snapshot.hasData) {
            var freehandGoals =
                snapshot.data![0] as List<FreehandGoalsModel>?; //freehand goals
            var userInfo = snapshot.data![1] as UserResponse; //user info
            var freehandMatch =
                snapshot.data![2] as FreehandMatchModel?; //freehand match

            String oponentFirstName,
                oponentLastName,
                oponentPhotoUrl,
                userScore,
                opponentScore = "";

            if (freehandMatch!.playerOneId == userInfo.id) {
              oponentFirstName = freehandMatch.playerTwoFirstName;
              oponentLastName = freehandMatch.playerTwoLastName;
              oponentPhotoUrl = freehandMatch.playerTwoPhotoUrl;
              userScore = freehandMatch.playerOneScore.toString();
              opponentScore = freehandMatch.playerTwoScore.toString();
            } else {
              oponentFirstName = freehandMatch.playerOneFirstName;
              oponentLastName = freehandMatch.playerOneLastName;
              oponentPhotoUrl = freehandMatch.playerOnePhotoUrl;
              userScore = freehandMatch.playerTwoScore.toString();
              opponentScore = freehandMatch.playerOneScore.toString();
            }

            return Container(
                color: helpers.getBackgroundColor(userState.darkmode),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        MatchCard(
                          userState: widget.twoPlayersObject.userState,
                          userFirstName: userInfo.firstName,
                          userLastName: userInfo.lastName,
                          userPhotoUrl: userInfo.photoUrl,
                          lefOrRight: true,
                        ),
                        MatchCard(
                          userState: widget.twoPlayersObject.userState,
                          userFirstName: oponentFirstName,
                          userLastName: oponentLastName,
                          userPhotoUrl: oponentPhotoUrl,
                          lefOrRight: false,
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        MatchScore(
                          userState: widget.twoPlayersObject.userState,
                          userScore: userScore,
                        ),
                        MatchScore(
                          userState: widget.twoPlayersObject.userState,
                          userScore: opponentScore,
                        ),
                      ],
                    ),
                    TotalPlayingTime(
                        userState: widget.twoPlayersObject.userState,
                        totalPlayingTime:
                            freehandMatch.totalPlayingTime.toString(),
                        totalPlayingTimeLabel: widget.twoPlayersObject.userState
                            .hardcodedStrings.totalPlayingTime),
                    FreehandMatchGoals(
                      userState: widget.twoPlayersObject.userState,
                      freehandGoals: freehandGoals,
                    ),
                    const Spacer(),
                    FreehandMatchButtons(userState: userState)
                  ],
                ));
          } else {
            return const CircularProgressIndicator();
          }
        },
      ),
    );
  }
}
