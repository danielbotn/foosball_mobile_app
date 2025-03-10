import 'dart:async';
import 'package:flutter/material.dart';
import 'package:dano_foosball/api/LeagueApi.dart';
import 'package:dano_foosball/api/SingleLeagueGoalApi.dart';
import 'package:dano_foosball/main.dart';
import 'package:dano_foosball/models/leagues/get-league-response.dart';
import 'package:dano_foosball/models/single-league-goals/single-league-goal-body/single_league_goal_body.dart';
import 'package:dano_foosball/models/single-league-goals/single-league-goal-create-response/single_league_goal_create_response.dart';
import 'package:dano_foosball/models/single-league-goals/single_league_goal_model.dart';
import 'package:dano_foosball/models/single-league-matches/single_league_match_model.dart';
import 'package:dano_foosball/models/user/user_response.dart';
import 'package:dano_foosball/state/user_state.dart';
import 'package:dano_foosball/utils/app_color.dart';
import 'package:dano_foosball/utils/helpers.dart';
import 'package:dano_foosball/widgets/UI/Error/ServerError.dart';
import 'package:dano_foosball/widgets/league/ongoing_game/match_details/match_details.dart';
import 'package:dano_foosball/widgets/league/ongoing_game/ongoing_game_button/ongoing_game_button.dart';
import 'package:dano_foosball/widgets/league/ongoing_game/player_card/playerCard.dart';
import 'package:dano_foosball/widgets/league/ongoing_game/player_score/player_score.dart';
import 'package:dano_foosball/widgets/league/ongoing_game/time_keeper/time_keeper.dart';
import 'package:dano_foosball/widgets/loading.dart';

class OngoingGame extends StatefulWidget {
  final UserState userState;
  final SingleLeagueMatchModel? matchModel;
  const OngoingGame(
      {super.key, required this.userState, required this.matchModel});

  @override
  State<OngoingGame> createState() => _OngoingGameState();
}

class _OngoingGameState extends State<OngoingGame> {
  late Future<GetLeagueResponse?> _leagueFuture;
  GetLeagueResponse? leagueData;
  bool gameStarted = false;
  int playerOneScore = 0;
  int playerTwoScore = 0;
  late Duration duration = const Duration();
  Timer? timer;

  @override
  void initState() {
    super.initState();
    _leagueFuture = getLeagueById();
  }

  @override
  void dispose() {
    // Cancel the timer to prevent setState being called after dispose
    timer?.cancel();
    super.dispose();
  }

  Future<GetLeagueResponse?> getLeagueById() async {
    LeagueApi api = LeagueApi();
    var data = await api.getLeagueById(widget.matchModel!.leagueId);
    setState(() {
      leagueData = data;
    });
    return data;
  }

  UserResponse getPlayerOne() {
    UserResponse userResponse = UserResponse(
        id: widget.matchModel!.playerOne,
        email: '',
        firstName: widget.matchModel!.playerOneFirstName,
        lastName: widget.matchModel!.playerOneLastName,
        createdAt: DateTime.now(),
        currentOrganisationId: widget.userState.currentOrganisationId,
        photoUrl: widget.matchModel!.playerOnePhotoUrl,
        isAdmin: false,
        isDeleted: false);
    return userResponse;
  }

  UserResponse getPlayerTwo() {
    UserResponse userResponse = UserResponse(
        id: widget.matchModel!.playerTwo,
        email: '',
        firstName: widget.matchModel!.playerTwoFirstName,
        lastName: widget.matchModel!.playerTwoLastName,
        createdAt: DateTime.now(),
        currentOrganisationId: widget.userState.currentOrganisationId,
        photoUrl: widget.matchModel!.playerTwoPhotoUrl,
        isAdmin: false,
        isDeleted: false);
    return userResponse;
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

  bool isWinnerGoal(int goal) {
    bool result = false;
    if (leagueData!.upTo == goal) {
      result = true;
    }

    return result;
  }

  void checkIfGameIsOver(SingleLeagueGoalCreateResponse data) {
    if (data.winnerGoal == true) {
      // Go to match result screen
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => MatchDetails(
                    userState: userState,
                    matchModel: widget.matchModel,
                  )));
    }
  }

  Future createGoalForPlayerOne() async {
    SingleLeagueGoalApi api = SingleLeagueGoalApi();
    var playerOne = getPlayerOne();
    var playerTwo = getPlayerTwo();
    SingleLeagueGoalBody goalBody = SingleLeagueGoalBody(
        matchId: widget.matchModel!.id,
        scoredByUserId: playerOne.id,
        opponentId: playerTwo.id,
        scorerScore: playerOneScore + 1,
        opponentScore: playerTwoScore,
        winnerGoal: isWinnerGoal(playerOneScore + 1));

    var data = await api.createSingleLeagueGoal(goalBody);

    if (data != null) {
      setState(() {
        playerOneScore = data.scorerScore;
      });
      checkIfGameIsOver(data);
    }
  }

  Future createGoalForPlayerTwo() async {
    SingleLeagueGoalApi api = SingleLeagueGoalApi();
    var playerOne = getPlayerOne();
    var playerTwo = getPlayerTwo();
    SingleLeagueGoalBody goalBody = SingleLeagueGoalBody(
        matchId: widget.matchModel!.id,
        scoredByUserId: playerTwo.id,
        opponentId: playerOne.id,
        scorerScore: playerTwoScore + 1,
        opponentScore: playerOneScore,
        winnerGoal: isWinnerGoal(playerTwoScore + 1));

    var data = await api.createSingleLeagueGoal(goalBody);

    if (data != null) {
      setState(() {
        playerTwoScore = data.scorerScore;
      });
      checkIfGameIsOver(data);
    }
  }

  Future<List<SingleLeagueGoalModel>?> getGoals() async {
    SingleLeagueGoalApi api = SingleLeagueGoalApi();
    var goals = await api.getSingleLeagueGoals(
        widget.matchModel!.leagueId, widget.matchModel!.id);
    return goals;
  }

  Future<bool> deleteLastGoal(int lastGoalId) async {
    SingleLeagueGoalApi api = SingleLeagueGoalApi();
    return await api.deleteSingleLeagueGoal(lastGoalId);
  }

  void deleteLastScoredGoal() async {
    if (gameStarted == true) {
      var allGoals = await getGoals();
      if (allGoals != null) {
        SingleLeagueGoalModel lastGoal = allGoals[allGoals.length - 1];
        bool goalDeleted = await deleteLastGoal(lastGoal.id);
        if (goalDeleted) {
          // successfully deleted goal
          if (lastGoal.scoredByUserId == getPlayerOne().id &&
              playerOneScore > 0) {
            setState(() {
              playerOneScore -= 1;
            });
          } else {
            if (playerTwoScore > 0) {
              setState(() {
                playerTwoScore -= 1;
              });
            }
          }
        } else {
          // could not delete goal
        }
      }
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
              visible: gameStarted == true &&
                  (playerOneScore > 0 || playerTwoScore > 0),
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
                        userState: userState,
                        duration: duration,
                      )),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        key: const Key('sl_match_player_one'),
                        onTap: () {
                          createGoalForPlayerOne();
                        },
                        child: PlayerCard(
                          userState: widget.userState,
                          player: getPlayerOne(),
                          isPlayerOne: true,
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: PlayerScore(
                          userState: widget.userState,
                          score: playerOneScore,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        key: const Key('sl_match_player_two'),
                        onTap: () {
                          createGoalForPlayerTwo();
                        },
                        child: PlayerCard(
                          userState: widget.userState,
                          player: getPlayerTwo(),
                          isPlayerOne: false,
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: PlayerScore(
                          userState: widget.userState,
                          score: playerTwoScore,
                        ),
                      ),
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
              return ServerError(userState: widget.userState);
            } else {
              return const Text('No data found');
            }
          },
        ));
  }
}
