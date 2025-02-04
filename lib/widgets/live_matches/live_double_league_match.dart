import 'package:dano_foosball/api/DoubleLeagueMatchApi.dart';
import 'package:dano_foosball/models/double-league-matches/double_league_match_model.dart';
import 'package:dano_foosball/models/other/ongoing_double_game_object.dart';
import 'package:dano_foosball/models/user/user_response.dart';
import 'package:dano_foosball/state/ongoing_double_freehand_state.dart';
import 'package:dano_foosball/state/user_state.dart';
import 'package:dano_foosball/utils/helpers.dart';
import 'package:dano_foosball/widgets/UI/Error/ServerError.dart';
import 'package:dano_foosball/widgets/emptyData/emptyData.dart';
import 'package:dano_foosball/widgets/extended_Text.dart';
import 'package:dano_foosball/widgets/loading.dart';
import 'package:dano_foosball/widgets/ongoing_double_freehand_game/player_card.dart';
import 'package:dano_foosball/widgets/ongoing_double_freehand_game/player_score.dart';
import 'package:flutter/material.dart';
import 'package:signalr_netcore/signalr_client.dart' as signalr;
import 'package:dano_foosball/models/live-matches/match.dart';

class LiveDoubleLeagueMatch extends StatefulWidget {
  final UserState userState;
  final int matchId;
  final signalr.HubConnection hubConnection;

  const LiveDoubleLeagueMatch({
    super.key,
    required this.userState,
    required this.matchId,
    required this.hubConnection,
  });

  @override
  State<LiveDoubleLeagueMatch> createState() => _LiveDoubleLeagueMatchState();
}

class _LiveDoubleLeagueMatchState extends State<LiveDoubleLeagueMatch> {
  late Future<DoubleLeagueMatchModel?> matchFuture;
  // STATE
  int teamOneScore = 0;
  int teamTwoScore = 0;

  @override
  void initState() {
    super.initState();
    // Call the API and store the future
    matchFuture = DoubleLeagueMatchApi().getDoubleLeagueMatch(widget.matchId);

    // Handle the future result
    matchFuture.then((data) {
      if (data != null) {
        setState(() {
          teamOneScore = data.teamOneScore;
          teamTwoScore = data.teamTwoScore;
        });
      }
    }).catchError((error) {
      // Handle errors here
    });

    widget.hubConnection.on('SendLiveMatches', _handleScoreUpdate);
  }

  String constructSnackbarMessage(Match updatedMatch) {
    if (updatedMatch.lastGoal != null) {
      return '${updatedMatch.lastGoal?.scorer.firstName} ${updatedMatch.lastGoal?.scorer.lastName} scored a goal!';
    }
    return '';
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
          teamOneScore = updatedMatch.userScore;
          teamTwoScore = updatedMatch.opponentUserOrTeamScore;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    Helpers helpers = Helpers();

    return Scaffold(
      appBar: AppBar(
        title: ExtendedText(text: 'Live match', userState: widget.userState),
        leading: IconButton(
          icon: const Icon(Icons.chevron_left),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        iconTheme: helpers.getIconTheme(widget.userState.darkmode),
        backgroundColor: helpers.getBackgroundColor(widget.userState.darkmode),
      ),
      body: FutureBuilder<DoubleLeagueMatchModel?>(
        future: matchFuture,
        builder: (context, snapshot) {
          // While the future is loading, show a progress indicator
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Loading(userState: widget.userState);
          }
          // If there was an error, display an error message
          else if (snapshot.hasError) {
            return ServerError(userState: widget.userState);
          }
          // If the future is complete and has data, build the UI with the data
          else if (snapshot.hasData && snapshot.data != null) {
            var matchData = snapshot.data!;

            // Initialize ongoingDoubleGameObject and ongoingState here after the data is fetched
            var playerOneTeamA = UserResponse(
              id: matchData.teamOne[0].userId,
              firstName: matchData.teamOne[0].firstName,
              lastName: matchData.teamOne[0].lastName,
              photoUrl: matchData.teamOne[0].photoUrl,
              email: matchData.teamOne[0].email,
              createdAt: DateTime.now(),
              currentOrganisationId: widget.userState.currentOrganisationId,
              isDeleted: false,
            );

            var playerTwoTeamA = UserResponse(
              id: matchData.teamOne[1].userId,
              firstName: matchData.teamOne[1].firstName,
              lastName: matchData.teamOne[1].lastName,
              photoUrl: matchData.teamOne[1].photoUrl,
              email: matchData.teamOne[1].email,
              createdAt: DateTime.now(),
              currentOrganisationId: widget.userState.currentOrganisationId,
              isDeleted: false,
            );

            var playerOneTeamB = UserResponse(
              id: matchData.teamTwo[0].userId,
              firstName: matchData.teamTwo[0].firstName,
              lastName: matchData.teamTwo[0].lastName,
              photoUrl: matchData.teamTwo[0].photoUrl,
              email: matchData.teamTwo[0].email,
              createdAt: DateTime.now(),
              currentOrganisationId: widget.userState.currentOrganisationId,
              isDeleted: false,
            );

            var playerTwoTeamB = matchData.teamTwo != null
                ? UserResponse(
                    id: matchData.teamTwo[1].userId,
                    firstName: matchData.teamTwo[1].firstName,
                    lastName: matchData.teamTwo[1].lastName,
                    photoUrl: matchData.teamTwo[1].photoUrl,
                    email: matchData.teamTwo[1].email,
                    createdAt: DateTime.now(),
                    currentOrganisationId:
                        widget.userState.currentOrganisationId,
                    isDeleted: false,
                  )
                : null;

            var ongoingState = OngoingDoubleFreehandState();
            ongoingState.setTeamOne(
                playerOneTeamA, playerTwoTeamA, matchData.teamOneScore);
            ongoingState.setTeamTwo(
                playerOneTeamB,
                playerTwoTeamB ??
                    UserResponse(
                      id: 0,
                      email: '',
                      firstName: '',
                      lastName: '',
                      createdAt: DateTime.now(),
                      currentOrganisationId: null,
                      photoUrl: '',
                      isAdmin: null,
                      isDeleted: false,
                    ),
                matchData.teamTwoScore);

            var ongoingDoubleGameObject = OngoingDoubleGameObject(
              userState: widget.userState,
              freehandDoubleMatchCreateResponse: null,
              playerOneTeamA: playerOneTeamA,
              playerTwoTeamA: playerTwoTeamA,
              playerOneTeamB: playerOneTeamB,
              playerTwoTeamB: playerTwoTeamB ??
                  UserResponse(
                    id: 0,
                    email: '',
                    firstName: '',
                    lastName: '',
                    createdAt: DateTime.now(),
                    currentOrganisationId: null,
                    photoUrl: '',
                    isAdmin: null,
                    isDeleted: false,
                  ),
            );

            // Your existing UI goes here
            return Container(
              color: helpers.getBackgroundColor(widget.userState.darkmode),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 1,
                        child: Column(
                          children: [
                            PlayerCard(
                              ongoingDoubleGameObject: ongoingDoubleGameObject,
                              userState: widget.userState,
                              ongoingState: ongoingState,
                              player: playerOneTeamA,
                              whichPlayer: 'teamOnePlayerOne',
                              notifyParent: refreshScoreWidget,
                              stopClockFromChild: stopClockFromChild,
                              preventScoreIncrease: true,
                            ),
                            PlayerCard(
                              ongoingDoubleGameObject: ongoingDoubleGameObject,
                              userState: widget.userState,
                              ongoingState: ongoingState,
                              player: playerTwoTeamA,
                              whichPlayer: 'teamOnePlayerTwo',
                              notifyParent: refreshScoreWidget,
                              stopClockFromChild: stopClockFromChild,
                              preventScoreIncrease: true,
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: PlayerScore(
                          userState: widget.userState,
                          isTeamOne: true,
                          ongoingState: ongoingState,
                          overrideScore: teamOneScore,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 1,
                        child: Column(
                          children: [
                            PlayerCard(
                              ongoingDoubleGameObject: ongoingDoubleGameObject,
                              userState: widget.userState,
                              ongoingState: ongoingState,
                              player: playerOneTeamB,
                              whichPlayer: 'teamTwoPlayerOne',
                              notifyParent: refreshScoreWidget,
                              stopClockFromChild: stopClockFromChild,
                              preventScoreIncrease: true,
                            ),
                            PlayerCard(
                              ongoingDoubleGameObject: ongoingDoubleGameObject,
                              userState: widget.userState,
                              ongoingState: ongoingState,
                              player: playerTwoTeamB ??
                                  UserResponse(
                                    id: 0,
                                    email: '',
                                    firstName: '',
                                    lastName: '',
                                    createdAt: DateTime.now(),
                                    currentOrganisationId: null,
                                    photoUrl: '',
                                    isAdmin: null,
                                    isDeleted: false,
                                  ),
                              whichPlayer: 'teamTwoPlayerTwo',
                              notifyParent: refreshScoreWidget,
                              stopClockFromChild: stopClockFromChild,
                              preventScoreIncrease: true,
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: PlayerScore(
                          userState: widget.userState,
                          isTeamOne: false,
                          ongoingState: ongoingState,
                          overrideScore: teamTwoScore,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          }
          // If the data is null, display a message
          else {
            return EmptyData(
                userState: widget.userState,
                message: 'Match data not available',
                iconData: Icons.person_off_sharp);
          }
        },
      ),
    );
  }

  void refreshScoreWidget() {
    setState(() {});
  }

  void stopClockFromChild() {
    // Your implementation for stopping the clock
  }
}
