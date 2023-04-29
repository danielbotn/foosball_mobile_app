import 'dart:async';

import 'package:flutter/material.dart';
import 'package:foosball_mobile_app/main.dart';
import 'package:foosball_mobile_app/models/single-league-matches/single_league_match_model.dart';
import 'package:foosball_mobile_app/models/user/user_response.dart';
import 'package:foosball_mobile_app/state/user_state.dart';
import 'package:foosball_mobile_app/utils/app_color.dart';
import 'package:foosball_mobile_app/utils/helpers.dart';
import 'package:foosball_mobile_app/widgets/league/ongoing_game/ongoing_game_button/ongoing_game_button.dart';
import 'package:foosball_mobile_app/widgets/league/ongoing_game/player_card/playerCard.dart';
import 'package:foosball_mobile_app/widgets/league/ongoing_game/player_score/player_score.dart';
import 'package:foosball_mobile_app/widgets/league/ongoing_game/time_keeper/time_keeper.dart';

class OngoingGame extends StatefulWidget {
  final UserState userState;
  final SingleLeagueMatchModel? matchModel;
  const OngoingGame(
      {super.key, required this.userState, required this.matchModel});

  @override
  State<OngoingGame> createState() => _OngoingGameState();
}

class _OngoingGameState extends State<OngoingGame> {
  bool gameStarted = false;
  int playerOneScore = 0;
  int playerTwoScore = 0;
  late Duration duration = const Duration();
  Timer? timer;

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
                : AppColors.white),
        body: Container(
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
                Expanded(
                  flex: 1,
                  child: PlayerCard(
                      userState: widget.userState,
                      player: getPlayerOne(),
                      isPlayerOne: true),
                ),
                Expanded(
                  flex: 1,
                  child: PlayerScore(
                      userState: widget.userState, score: playerOneScore),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 1,
                  child: PlayerCard(
                      userState: widget.userState,
                      player: getPlayerTwo(),
                      isPlayerOne: false),
                ),
                Expanded(
                  flex: 1,
                  child: PlayerScore(
                      userState: widget.userState, score: playerTwoScore),
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
        ));
  }
}
