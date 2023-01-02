import 'package:flutter/material.dart';
import 'package:foosball_mobile_app/api/FreehandDoubleGoalsApi.dart';
import 'package:foosball_mobile_app/api/FreehandDoubleMatchApi.dart';
import 'package:foosball_mobile_app/api/UserApi.dart';
import 'package:foosball_mobile_app/main.dart';
import 'package:foosball_mobile_app/models/freehand-double-goals/freehand_double_goal_model.dart';
import 'package:foosball_mobile_app/models/freehand-double-matches/freehand_double_match_model.dart';
import 'package:foosball_mobile_app/models/other/TwoPlayersObject.dart';
import 'package:foosball_mobile_app/models/other/freehandDoubleMatchObject.dart';
import 'package:foosball_mobile_app/models/user/user_response.dart';
import 'package:foosball_mobile_app/utils/helpers.dart';
import '../extended_Text.dart';
import '../match_score.dart';
import '../total_playing_time.dart';
import 'freehand_double_goals.dart';
import 'freehand_double_match_buttons.dart';
import 'freehand_double_match_card.dart';

class FreehandDoubleMatchDetail extends StatefulWidget {
  // props
  final TwoPlayersObject twoPlayersObject;
  const FreehandDoubleMatchDetail({
    Key? key,
    required this.twoPlayersObject,
  }) : super(key: key);

  @override
  State<FreehandDoubleMatchDetail> createState() =>
      _FreehandDoubleMatchDetailState();
}

class _FreehandDoubleMatchDetailState extends State<FreehandDoubleMatchDetail> {
  // State variables
  late Future<List<FreehandDoubleGoalModel>?> freehandDoubleGoalsFuture;
  late Future<UserResponse> userFuture;
  late Future<FreehandDoubleMatchModel?> freehandDoubleMatchFuture;

  @override
  void initState() {
    super.initState();

    freehandDoubleGoalsFuture = getFreehandDoubleGoals();
    userFuture = getUser();
    freehandDoubleMatchFuture = getFreehandDoubleMatch();
  }

  Future<List<FreehandDoubleGoalModel>?> getFreehandDoubleGoals() async {
    FreehandDoubleGoalsApi fgapi =
        FreehandDoubleGoalsApi(token: widget.twoPlayersObject.userState.token);
    var freehandGoals =
        await fgapi.getFreehandDoubleGoals(widget.twoPlayersObject.matchId);
    return freehandGoals;
  }

  Future<UserResponse> getUser() async {
    UserApi uapi = UserApi(token: widget.twoPlayersObject.userState.token);
    var user =
        await uapi.getUser(widget.twoPlayersObject.userState.userId.toString());
    return user;
  }

  Future<FreehandDoubleMatchModel?> getFreehandDoubleMatch() async {
    FreehandDoubleMatchApi fmapi =
        FreehandDoubleMatchApi(token: widget.twoPlayersObject.userState.token);
    var freehandMatch =
        await fmapi.getDoubleFreehandMatch(widget.twoPlayersObject.matchId);
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
        future: Future.wait(
            [freehandDoubleGoalsFuture, userFuture, freehandDoubleMatchFuture]),
        builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
          if (snapshot.hasData) {
            var freehandGoals = snapshot.data![0]
                as List<FreehandDoubleGoalModel>?; //freehand goals
            var userInfo = snapshot.data![1] as UserResponse; //user info
            var match =
                snapshot.data![2] as FreehandDoubleMatchModel?; //freehand match

            FreehandDoubleMatchObject matchObject =
                helpers.getFreehandDoubleMatchObject(match!, userInfo);

            return Container(
                color: helpers.getBackgroundColor(userState.darkmode),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        FreehandDoubleMatchCard(
                          userState: widget.twoPlayersObject.userState,
                          firstName: userInfo.firstName,
                          lastName: userInfo.lastName,
                          photoUrl: userInfo.photoUrl,
                          lefOrRight: true,
                        ),
                        FreehandDoubleMatchCard(
                          userState: widget.twoPlayersObject.userState,
                          firstName: matchObject.opponentOneFirstName,
                          lastName: matchObject.opponentOneLastName,
                          photoUrl: matchObject.opponentOnePhotoUrl,
                          lefOrRight: false,
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        FreehandDoubleMatchCard(
                          userState: widget.twoPlayersObject.userState,
                          firstName: matchObject.teamMateFirstName,
                          lastName: matchObject.teamMateLastName,
                          photoUrl: matchObject.teamMatePhotoUrl,
                          lefOrRight: true,
                        ),
                        Visibility(
                          visible: matchObject.opponentTwoFirstName != null,
                          child: FreehandDoubleMatchCard(
                            userState: widget.twoPlayersObject.userState,
                            firstName: matchObject.opponentTwoFirstName != null
                                ? matchObject.opponentTwoFirstName!
                                : "",
                            lastName: matchObject.opponentTwoLastName != null
                                ? matchObject.opponentTwoLastName!
                                : "",
                            photoUrl: matchObject.opponentTwoPhotoUrl != null
                                ? matchObject.opponentTwoPhotoUrl!
                                : "",
                            lefOrRight: false,
                          ),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        MatchScore(
                          userState: widget.twoPlayersObject.userState,
                          userScore: matchObject.userScore,
                        ),
                        MatchScore(
                          userState: widget.twoPlayersObject.userState,
                          userScore: matchObject.opponentScore,
                        ),
                      ],
                    ),
                    TotalPlayingTime(
                        userState: widget.twoPlayersObject.userState,
                        totalPlayingTime: match.totalPlayingTime,
                        totalPlayingTimeLabel: widget.twoPlayersObject.userState
                            .hardcodedStrings.totalPlayingTime),
                    FreehandDoubleGoals(
                      userState: widget.twoPlayersObject.userState,
                      freehandGoals: freehandGoals,
                    ),
                    const Spacer(),
                    FreehandDoubleMatchButtons(
                      userState: userState,
                      matchData: match,
                    )
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
