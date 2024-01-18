import 'dart:async';
import 'package:flutter/material.dart';
import 'package:foosball_mobile_app/api/DoubleLeagueGoalsApi.dart';
import 'package:foosball_mobile_app/api/LeagueApi.dart';
import 'package:foosball_mobile_app/models/double-league-goals/double-league-goal-body.dart';
import 'package:foosball_mobile_app/models/double-league-goals/double_league_goal_create_response.dart';
import 'package:foosball_mobile_app/models/double-league-matches/double_league_match_model.dart';
import 'package:foosball_mobile_app/models/leagues/get-league-response.dart';
import 'package:foosball_mobile_app/models/user/user_response.dart';
import 'package:foosball_mobile_app/state/user_state.dart';
import 'package:foosball_mobile_app/utils/app_color.dart';
import 'package:foosball_mobile_app/utils/helpers.dart';
import 'package:foosball_mobile_app/widgets/extended_Text.dart';
import 'package:foosball_mobile_app/widgets/league/ongoing_double_game/ongoing_double_game_button/ongoing_double_game_button.dart';
import 'package:foosball_mobile_app/widgets/league/ongoing_game/player_card/playerCard.dart';
import 'package:foosball_mobile_app/widgets/league/ongoing_game/player_score/player_score.dart';
import 'package:foosball_mobile_app/widgets/league/ongoing_game/time_keeper/time_keeper.dart';
import 'package:foosball_mobile_app/widgets/loading.dart';

class OngoingDoubleGame extends StatefulWidget {
  final UserState userState;
  final DoubleLeagueMatchModel matchModel;
  const OngoingDoubleGame(
      {super.key, required this.userState, required this.matchModel});

  @override
  State<OngoingDoubleGame> createState() => _OngoingDoubleGameState();
}

class _OngoingDoubleGameState extends State<OngoingDoubleGame> {
  late Future<GetLeagueResponse?> _leagueFuture;
  GetLeagueResponse? leagueData;
  bool gameStarted = false;
  int teamOneScore = 0;
  int teamTwoScore = 0;
  late Duration duration = const Duration();
  Timer? timer;

  @override
  void initState() {
    super.initState();
    _leagueFuture = getLeagueById();
  }

  Future<GetLeagueResponse?> getLeagueById() async {
    LeagueApi api = LeagueApi();
    var data = await api.getLeagueById(widget.matchModel!.leagueId);
    setState(() {
      leagueData = data;
    });
    return data;
  }

  void startGame(bool value) {
    setState(() {
      gameStarted = value;
    });
    startTime();
  }

  void addTime() {
    const addSeconds = 1;
    final seconds = duration.inSeconds + addSeconds;
    setState(() {
      duration = Duration(seconds: seconds);
    });
  }

  void startTime() {
    // start timer
    setState(() {
      timer = Timer.periodic(const Duration(seconds: 1), (_) => addTime());
    });
  }

  UserResponse getPlayerOneTeamOne() {
    UserResponse userResponse = UserResponse(
        id: widget.matchModel.teamOne[0].id,
        email: widget.matchModel.teamOne[0].email,
        firstName: widget.matchModel.teamOne[0].firstName,
        lastName: widget.matchModel.teamOne[0].lastName,
        createdAt: DateTime.now(),
        currentOrganisationId: widget.userState.currentOrganisationId,
        photoUrl: widget.matchModel.teamOne[0].photoUrl,
        isAdmin: false,
        isDeleted: false);
    return userResponse;
  }

  UserResponse getPlayerTwoTeamOne() {
    UserResponse userResponse = UserResponse(
        id: widget.matchModel.teamOne[1].id,
        email: widget.matchModel.teamOne[1].email,
        firstName: widget.matchModel.teamOne[1].firstName,
        lastName: widget.matchModel.teamOne[1].lastName,
        createdAt: DateTime.now(),
        currentOrganisationId: widget.userState.currentOrganisationId,
        photoUrl: widget.matchModel.teamOne[1].photoUrl,
        isAdmin: false,
        isDeleted: false);
    return userResponse;
  }

  UserResponse getPlayerOneTeamTwo() {
    UserResponse userResponse = UserResponse(
        id: widget.matchModel.teamTwo[0].id,
        email: widget.matchModel.teamTwo[0].email,
        firstName: widget.matchModel.teamTwo[0].firstName,
        lastName: widget.matchModel.teamTwo[0].lastName,
        createdAt: DateTime.now(),
        currentOrganisationId: widget.userState.currentOrganisationId,
        photoUrl: widget.matchModel.teamTwo[0].photoUrl,
        isAdmin: false,
        isDeleted: false);
    return userResponse;
  }

  UserResponse getPlayerTwoTeamTwo() {
    UserResponse userResponse = UserResponse(
        id: widget.matchModel.teamTwo[1].id,
        email: widget.matchModel.teamTwo[1].email,
        firstName: widget.matchModel.teamTwo[1].firstName,
        lastName: widget.matchModel.teamTwo[1].lastName,
        createdAt: DateTime.now(),
        currentOrganisationId: widget.userState.currentOrganisationId,
        photoUrl: widget.matchModel.teamTwo[1].photoUrl,
        isAdmin: false,
        isDeleted: false);
    return userResponse;
  }

  void deleteLastScoredGoal() async {
    // if (gameStarted == true) {
    //   var allGoals = await getGoals();
    //   if (allGoals != null) {
    //     DoubleLeagueGoalModel lastGoal = allGoals[allGoals.length - 1];
    //     bool goalDeleted = await deleteLastGoal(lastGoal.id);
    //     if (goalDeleted) {
    //       // successfully deleted goal
    //       if (lastGoal.scoredByUserId == getPlayerOne().id &&
    //           playerOneScore > 0) {
    //         setState(() {
    //           playerOneScore -= 1;
    //         });
    //       } else {
    //         if (playerTwoScore > 0) {
    //           setState(() {
    //             playerTwoScore -= 1;
    //           });
    //         }
    //       }
    //     } else {
    //       // could not delete goal
    //     }
    //   }
    // }
  }

  bool isWinnerGoal(int goal) {
    bool result = false;
    if (leagueData!.upTo == goal) {
      result = true;
    }

    return result;
  }

  void checkIfGameIsOver(DoubleLeagueGoalCreateResponse data) {
    if (data.winnerGoal == true) {
      // Go to match result screen
      // Navigator.push(
      //     context,
      //     MaterialPageRoute(
      //         builder: (context) => MatchDetails(
      //               userState: userState,
      //               matchModel: widget.matchModel,
      //             )));
    }
  }

  Future createGoalForTeamOne(bool isPlayerOne) async {
    DoubleLeagueGoalsApi api = DoubleLeagueGoalsApi();
    var playerOne = getPlayerOneTeamOne();
    var playerTwo = getPlayerTwoTeamOne();
    DoubleLeagueGoalBody goalBody = DoubleLeagueGoalBody(
        matchId: widget.matchModel.id,
        scoredByTeamId: widget.matchModel.teamOne[0].id,
        opponentTeamId: widget.matchModel.teamOne[1].id,
        scorerTeamScore: teamOneScore + 1,
        opponentTeamScore: teamTwoScore,
        userScorerId: isPlayerOne ? playerOne.id : playerTwo.id,
        timeOfGoal: DateTime.now(),
        winnerGoal: isWinnerGoal(teamOneScore + 1));

    var data = await api.createDoubleLeagueGoal(goalBody);

    if (data != null) {
      setState(() {
        teamOneScore = data.scorerTeamScore;
      });
      checkIfGameIsOver(data);
    }
  }

  Future createGoalForTeamTwo(bool isPlayerOne) async {
    DoubleLeagueGoalsApi api = DoubleLeagueGoalsApi();
    var playerOne = getPlayerOneTeamTwo();
    var playerTwo = getPlayerTwoTeamTwo();
    DoubleLeagueGoalBody goalBody = DoubleLeagueGoalBody(
        matchId: widget.matchModel.id,
        scoredByTeamId: widget.matchModel.teamTwo[0].id,
        opponentTeamId: widget.matchModel.teamTwo[1].id,
        scorerTeamScore: teamTwoScore + 1,
        opponentTeamScore: teamOneScore,
        userScorerId: isPlayerOne ? playerOne.id : playerTwo.id,
        timeOfGoal: DateTime.now(),
        winnerGoal: isWinnerGoal(teamTwoScore + 1));

    var data = await api.createDoubleLeagueGoal(goalBody);

    if (data != null) {
      setState(() {
        teamTwoScore = data.scorerTeamScore;
      });
      checkIfGameIsOver(data);
    }
  }

  @override
  Widget build(BuildContext context) {
    Helpers helpers = Helpers();
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.chevron_left),
            onPressed: () {
              Navigator.pop(context, widget.userState);
            },
          ),
          iconTheme: widget.userState.darkmode
              ? const IconThemeData(color: AppColors.white)
              : IconThemeData(color: Colors.grey[700]),
          backgroundColor: widget.userState.darkmode
              ? AppColors.darkModeBackground
              : AppColors.white,
          actions: <Widget>[
            Visibility(
              visible:
                  gameStarted == true && (teamOneScore > 0 || teamTwoScore > 0),
              child: Padding(
                  padding: const EdgeInsets.only(right: 20.0),
                  child: GestureDetector(
                    onTap: () {
                      deleteLastScoredGoal();
                    },
                    child: const Icon(
                      Icons.undo,
                      size: 26.0,
                    ),
                  )),
            )
          ],
        ),
        body: FutureBuilder<GetLeagueResponse?>(
          future: _leagueFuture,
          builder: (BuildContext context,
              AsyncSnapshot<GetLeagueResponse?> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Loading(
                userState: widget.userState,
              );
            }
            if (snapshot.hasData) {
              return Container(
                color: helpers.getBackgroundColor(widget.userState.darkmode),
                child: Column(
                  children: [
                    Visibility(
                      visible: gameStarted,
                      child: TimeKeeper(
                        userState: widget.userState,
                        duration: duration,
                      ),
                    ),
                    // Team One
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          flex: 1,
                          child: GestureDetector(
                            onTap: () {
                              createGoalForTeamOne(true);
                            },
                            child: PlayerCard(
                              userState: widget.userState,
                              player: getPlayerOneTeamOne(),
                              isPlayerOne: true,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: GestureDetector(
                            onTap: () {
                              createGoalForTeamOne(false);
                            },
                            child: PlayerCard(
                              userState: widget.userState,
                              player: getPlayerTwoTeamOne(),
                              isPlayerOne: false,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          children: [
                            ExtendedText(
                              text: widget.matchModel.teamOne[0].teamName,
                              userState: widget.userState,
                              fontSize: 20,
                              isBold: true,
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            PlayerScore(
                              userState: widget.userState,
                              score: teamOneScore,
                            ),
                          ],
                        ),
                      ],
                    ),

                    // Team Two
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          flex: 1,
                          child: GestureDetector(
                            onTap: () {
                              createGoalForTeamTwo(true);
                            },
                            child: PlayerCard(
                              userState: widget.userState,
                              player: getPlayerOneTeamTwo(),
                              isPlayerOne: true,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: GestureDetector(
                            onTap: () {
                              createGoalForTeamTwo(false);
                            },
                            child: PlayerCard(
                              userState: widget.userState,
                              player: getPlayerTwoTeamTwo(),
                              isPlayerOne: false,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          children: [
                            ExtendedText(
                              text: widget.matchModel.teamTwo[0].teamName,
                              userState: widget.userState,
                              fontSize: 20,
                              isBold: true,
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            PlayerScore(
                              userState: widget.userState,
                              score: teamTwoScore,
                            ),
                          ],
                        ),
                      ],
                    ),

                    const Spacer(),
                    OnGoingDoubleGameButton(
                      gameStarted: gameStarted,
                      userState: widget.userState,
                      matchId: widget.matchModel.id,
                      startGameFunction: (value) {
                        startGame(value);
                      },
                    ),
                  ],
                ),
              );
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              return const Text('No data found');
            }
          },
        ));
  }
}
