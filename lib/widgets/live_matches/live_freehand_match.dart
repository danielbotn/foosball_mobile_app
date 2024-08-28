import 'package:dano_foosball/models/freehand-matches/freehand_match_create_response.dart';
import 'package:dano_foosball/models/other/ongoing_game_object.dart';
import 'package:dano_foosball/models/user/user_response.dart';
import 'package:dano_foosball/state/user_state.dart';
import 'package:dano_foosball/utils/app_color.dart';
import 'package:flutter/material.dart';
import 'package:dano_foosball/api/FreehandMatchApi.dart';
import 'package:dano_foosball/models/freehand-matches/freehand_match_model.dart';
import 'package:dano_foosball/state/ongoing_freehand_state.dart';
import 'package:dano_foosball/widgets/ongoing_freehand_game/player_card.dart';
import 'package:dano_foosball/widgets/ongoing_freehand_game/player_score.dart';
import 'package:signalr_netcore/signalr_client.dart' as signalr;
import 'package:dano_foosball/utils/helpers.dart';
import 'package:dano_foosball/models/live-matches/match.dart';

class LiveFreehandMatch extends StatefulWidget {
  final UserState userState;
  final signalr.HubConnection hubConnection; // Receive the hub connection
  final int matchId;

  const LiveFreehandMatch({
    super.key,
    required this.userState,
    required this.hubConnection,
    required this.matchId,
  });

  @override
  State<LiveFreehandMatch> createState() => _LiveFreehandMatchState();
}

class _LiveFreehandMatchState extends State<LiveFreehandMatch> {
  late Future<FreehandMatchModel?> _matchFuture;
  late OngoingFreehandState counter;
  // State
  late UserResponse playerOne = UserResponse(
    id: 0,
    email: '',
    firstName: '',
    lastName: '',
    createdAt: DateTime.now(),
    currentOrganisationId: null,
    photoUrl: '',
    isAdmin: false,
    isDeleted: false,
  );

  late UserResponse playerTwo = UserResponse(
    id: 1,
    email: '',
    firstName: '',
    lastName: '',
    createdAt: DateTime.now(),
    currentOrganisationId: null,
    photoUrl: '',
    isAdmin: false,
    isDeleted: false,
  );

  late FreehandMatchCreateResponse freehandMatchCreateResponse;

  int playerOneScore = 0;
  int playerTwoScore = 0;

  @override
  void initState() {
    super.initState();
    _matchFuture = _fetchMatchData();
    counter = OngoingFreehandState();

    widget.hubConnection.on('SendLiveMatches', _handleScoreUpdate);
  }

  Future<FreehandMatchModel?> _fetchMatchData() async {
    FreehandMatchApi api = FreehandMatchApi();
    var data = await api.getFreehandMatch(widget.matchId);
    if (data != null) {
      UserResponse tmpPlayerOne = UserResponse(
          id: data.playerOneId,
          email: '',
          firstName: data.playerOneFirstName,
          lastName: data.playerOneLastName,
          createdAt: DateTime.now(),
          currentOrganisationId: widget.userState.currentOrganisationId,
          photoUrl: data.playerOnePhotoUrl,
          isDeleted: false);

      UserResponse tmpPlayerTwo = UserResponse(
          id: data.playerTwoId,
          email: '',
          firstName: data.playerTwoFirstName,
          lastName: data.playerTwoLastName,
          createdAt: DateTime.now(),
          currentOrganisationId: widget.userState.currentOrganisationId,
          photoUrl: data.playerTwoPhotoUrl,
          isDeleted: false);

      FreehandMatchCreateResponse tmpFreehandMatchCreateResponse =
          FreehandMatchCreateResponse(
              id: widget.matchId,
              playerOneId: data.playerOneId,
              playerTwoId: data.playerTwoId,
              startTime: data.startTime,
              endTime: null,
              playerOneScore: data.playerOneScore,
              playerTwoScore: data.playerTwoScore,
              upTo: data.upTo,
              gameFinished: data.gameFinished,
              gamePaused: data.gamePaused,
              organisationId: widget.userState.currentOrganisationId);

      setState(() {
        playerOne = tmpPlayerOne;
        playerTwo = tmpPlayerTwo;
        playerOneScore = data.playerOneScore;
        playerTwoScore = data.playerTwoScore;
        freehandMatchCreateResponse = tmpFreehandMatchCreateResponse;
      });
    }

    return data;
  }

  String constructSnackbarMessage(Match updatedMatch) {
    if (updatedMatch.userScore > playerOneScore) {
      // If the userScore in updatedMatch is greater than the current playerOneScore
      return '${updatedMatch.userFirstName} ${updatedMatch.userLastName} scored a goal!';
    } else if (updatedMatch.opponentUserOrTeamScore > playerTwoScore) {
      // If the opponentUserOrTeamScore in updatedMatch is greater than the current playerTwoScore
      return '${updatedMatch.opponentOneFirstName} ${updatedMatch.opponentOneLastName} scored a goal!';
    } else {
      // If no score changes
      return '';
    }
  }

  void _handleScoreUpdate(List<Object?>? message) {
    if (message != null && message.isNotEmpty) {
      // Extract the match data from the message
      final matchData = message[0] as Map<String, dynamic>;

      // Parse the match data into a Match object
      final updatedMatch = Match.fromJson(matchData);

      // Check if the received match update corresponds to the current match
      if (updatedMatch.matchId == widget.matchId) {
        Helpers helpers = Helpers();
        var snackbarMessage = constructSnackbarMessage(updatedMatch);
        if (snackbarMessage != '') {
          helpers.showSnackbar(context, snackbarMessage, false);
        }

        setState(() {
          // Update the scores of the ongoing match
          counter.updatePlayerOneScore(updatedMatch.userScore);
          counter.updatePlayerTwoScore(updatedMatch.opponentUserOrTeamScore);
          playerOneScore = updatedMatch.userScore;
          playerTwoScore = updatedMatch.opponentUserOrTeamScore;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    Helpers helpers = Helpers();
    final isDarkMode = widget.userState.darkmode;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Live Match',
          style: TextStyle(
            color: isDarkMode ? AppColors.white : AppColors.textBlack,
          ),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.chevron_left,
            color: isDarkMode ? AppColors.white : Colors.grey[700],
          ),
          onPressed: () {
            Navigator.pop(context, widget.userState);
          },
        ),
        backgroundColor:
            isDarkMode ? AppColors.darkModeBackground : AppColors.white,
        iconTheme: IconThemeData(
            color: isDarkMode ? AppColors.white : Colors.grey[700]),
      ),
      body: FutureBuilder<FreehandMatchModel?>(
        future: _matchFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return const Center(child: Text('Match data not available'));
          } else {
            FreehandMatchModel match = snapshot.data!;
            counter.updatePlayerOneScore(match.playerOneScore);
            counter.updatePlayerTwoScore(match.playerTwoScore);

            return Container(
              color: helpers.getBackgroundColor(isDarkMode),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 1,
                        child: PlayerCard(
                            ongoingGameObject: OngoingGameObject(
                                playerOne: playerOne,
                                playerTwo: playerTwo,
                                userState: widget.userState,
                                freehandMatchCreateResponse:
                                    freehandMatchCreateResponse),
                            userState: widget.userState,
                            isPlayerOne: true,
                            counter: counter,
                            notifyParent: () {},
                            stopClockFromChild: () {},
                            disableScoreIncrease: true),
                      ),
                      Expanded(
                        flex: 1,
                        child: PlayerScore(
                          userState: widget.userState,
                          isPlayerOne: true,
                          counter: counter,
                          randomString: '',
                          overrideScore: playerOneScore,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 1,
                        child: PlayerCard(
                            ongoingGameObject: OngoingGameObject(
                                playerOne: playerOne,
                                playerTwo: playerTwo,
                                userState: widget.userState,
                                freehandMatchCreateResponse:
                                    freehandMatchCreateResponse),
                            userState: widget.userState,
                            isPlayerOne: false,
                            counter: counter,
                            notifyParent: () {},
                            stopClockFromChild: () {},
                            disableScoreIncrease: true),
                      ),
                      Expanded(
                        flex: 1,
                        child: PlayerScore(
                          userState: widget.userState,
                          isPlayerOne: false,
                          counter: counter,
                          randomString: '',
                          overrideScore: playerTwoScore,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }

  @override
  void dispose() {
    widget.hubConnection.off('UpdateScore');
    super.dispose();
  }
}
