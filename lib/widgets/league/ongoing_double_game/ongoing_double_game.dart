import 'dart:async';

import 'package:flutter/material.dart';
import 'package:foosball_mobile_app/api/LeagueApi.dart';
import 'package:foosball_mobile_app/models/double-league-goals/double_league_goal_model.dart';
import 'package:foosball_mobile_app/models/double-league-matches/double_league_match_model.dart';
import 'package:foosball_mobile_app/models/leagues/get-league-response.dart';
import 'package:foosball_mobile_app/models/user/user_response.dart';
import 'package:foosball_mobile_app/state/user_state.dart';
import 'package:foosball_mobile_app/utils/app_color.dart';
import 'package:foosball_mobile_app/utils/helpers.dart';
import 'package:foosball_mobile_app/widgets/league/ongoing_game/ongoing_game_button/ongoing_game_button.dart';
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

  Future createGoalForTeamOne() async {
    // SingleLeagueGoalApi api = SingleLeagueGoalApi();
    // var playerOne = getPlayerOne();
    // var playerTwo = getPlayerTwo();
    // SingleLeagueGoalBody goalBody = SingleLeagueGoalBody(
    //     matchId: widget.matchModel!.id,
    //     scoredByUserId: playerOne.id,
    //     opponentId: playerTwo.id,
    //     scorerScore: playerOneScore + 1,
    //     opponentScore: playerTwoScore,
    //     winnerGoal: isWinnerGoal(playerOneScore + 1));

    // var data = await api.createSingleLeagueGoal(goalBody);

    // if (data != null) {
    //   setState(() {
    //     playerOneScore = data.scorerScore;
    //   });
    //   checkIfGameIsOver(data);
    // }
  }

  Future createGoalForTeamTwo() async {
    // SingleLeagueGoalApi api = SingleLeagueGoalApi();
    // var playerOne = getPlayerOne();
    // var playerTwo = getPlayerTwo();
    // SingleLeagueGoalBody goalBody = SingleLeagueGoalBody(
    //     matchId: widget.matchModel!.id,
    //     scoredByUserId: playerOne.id,
    //     opponentId: playerTwo.id,
    //     scorerScore: playerOneScore + 1,
    //     opponentScore: playerTwoScore,
    //     winnerGoal: isWinnerGoal(playerOneScore + 1));

    // var data = await api.createSingleLeagueGoal(goalBody);

    // if (data != null) {
    //   setState(() {
    //     playerOneScore = data.scorerScore;
    //   });
    //   checkIfGameIsOver(data);
    // }
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
                child: Column(children: [
                  Visibility(
                      visible: gameStarted,
                      child: TimeKeeper(
                        userState: widget.userState,
                        duration: duration,
                      )),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          createGoalForTeamOne();
                        },
                        child: Expanded(
                          flex: 1,
                          child: PlayerCard(
                              userState: widget.userState,
                              player: getPlayerOneTeamOne(),
                              isPlayerOne: true),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: PlayerScore(
                            userState: widget.userState, score: teamOneScore),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                          onTap: () {
                            createGoalForTeamTwo();
                          },
                          child: Expanded(
                            flex: 1,
                            child: PlayerCard(
                                userState: widget.userState,
                                player: getPlayerOneTeamTwo(),
                                isPlayerOne: false),
                          )),
                      Expanded(
                        flex: 1,
                        child: PlayerScore(
                            userState: widget.userState, score: teamTwoScore),
                      )
                    ],
                  ),
                  const Spacer(),
                  OngoingGameButton(
                    gameStarted: gameStarted,
                    userState: widget.userState,
                    matchId: widget.matchModel!.id,
                    startGameFunction: (value) {
                      startGame(value);
                    },
                  ),
                ]),
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
