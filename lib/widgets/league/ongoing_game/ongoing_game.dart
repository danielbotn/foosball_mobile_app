import 'package:flutter/material.dart';
import 'package:foosball_mobile_app/models/single-league-matches/single_league_match_model.dart';
import 'package:foosball_mobile_app/models/user/user_response.dart';
import 'package:foosball_mobile_app/state/user_state.dart';
import 'package:foosball_mobile_app/utils/app_color.dart';
import 'package:foosball_mobile_app/utils/helpers.dart';
import 'package:foosball_mobile_app/widgets/league/ongoing_game/ongoing_game_button/ongoing_game_button.dart';
import 'package:foosball_mobile_app/widgets/league/ongoing_game/player_card/playerCard.dart';
import 'package:foosball_mobile_app/widgets/league/ongoing_game/player_score/player_score.dart';

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
                gameStarted: gameStarted, userState: widget.userState),
          ]),
        ));
  }
}
