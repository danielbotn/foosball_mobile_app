import 'package:dano_foosball/api/FreehandDoubleMatchApi.dart';
import 'package:dano_foosball/models/freehand-double-matches/freehand_double_match_model.dart';
import 'package:dano_foosball/models/other/ongoing_double_game_object.dart';
import 'package:dano_foosball/models/user/user_response.dart';
import 'package:dano_foosball/state/ongoing_double_freehand_state.dart';
import 'package:dano_foosball/state/user_state.dart';
import 'package:dano_foosball/utils/helpers.dart';
import 'package:dano_foosball/widgets/extended_Text.dart';
import 'package:dano_foosball/widgets/ongoing_double_freehand_game/player_card.dart';
import 'package:dano_foosball/widgets/ongoing_double_freehand_game/player_score.dart';
import 'package:flutter/material.dart';
import 'package:signalr_netcore/signalr_client.dart' as signalr;

class LiveDoubleFreehandMatch extends StatefulWidget {
  final UserState userState;
  final int matchId;
  // final signalr.HubConnection hubConnection;

  const LiveDoubleFreehandMatch({
    super.key,
    required this.userState,
    required this.matchId,
    // required this.hubConnection,
  });

  @override
  State<LiveDoubleFreehandMatch> createState() =>
      _LiveDoubleFreehandMatchState();
}

class _LiveDoubleFreehandMatchState extends State<LiveDoubleFreehandMatch> {
  late Future<FreehandDoubleMatchModel?> matchFuture;

  @override
  void initState() {
    super.initState();
    // Call the API and store the future
    matchFuture =
        FreehandDoubleMatchApi().getDoubleFreehandMatch(widget.matchId);
  }

  @override
  Widget build(BuildContext context) {
    Helpers helpers = Helpers();

    return Scaffold(
      appBar: AppBar(
        title: ExtendedText(text: 'Live match', userState: widget.userState),
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () {},
        ),
        iconTheme: helpers.getIconTheme(widget.userState.darkmode),
        backgroundColor: helpers.getBackgroundColor(widget.userState.darkmode),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: GestureDetector(
              onTap: () {},
              child: const Icon(
                Icons.undo,
                size: 26.0,
              ),
            ),
          ),
        ],
      ),
      body: FutureBuilder<FreehandDoubleMatchModel?>(
        future: matchFuture,
        builder: (context, snapshot) {
          // While the future is loading, show a progress indicator
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          // If there was an error, display an error message
          else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          // If the future is complete and has data, build the UI with the data
          else if (snapshot.hasData && snapshot.data != null) {
            var matchData = snapshot.data!;

            // Initialize ongoingDoubleGameObject and ongoingState here after the data is fetched
            var playerOneTeamA = UserResponse(
              id: matchData.playerOneTeamA,
              firstName: matchData.playerOneTeamAFirstName,
              lastName: matchData.playerOneTeamALastName,
              photoUrl: matchData.playerOneTeamAPhotoUrl,
              email: '',
              createdAt: DateTime.now(),
              currentOrganisationId: widget.userState.currentOrganisationId,
              isDeleted: false,
            );

            var playerTwoTeamA = UserResponse(
              id: matchData.playerTwoTeamA,
              firstName: matchData.playerTwoTeamAFirstName,
              lastName: matchData.playerTwoTeamALastName,
              photoUrl: matchData.playerTwoTeamAPhotoUrl,
              email: '',
              createdAt: DateTime.now(),
              currentOrganisationId: widget.userState.currentOrganisationId,
              isDeleted: false,
            );

            var playerOneTeamB = UserResponse(
              id: matchData.playerOneTeamB,
              firstName: matchData.playerOneTeamBFirstName,
              lastName: matchData.playerOneTeamBLastName,
              photoUrl: matchData.playerOneTeamBPhotoUrl,
              email: '',
              createdAt: DateTime.now(),
              currentOrganisationId: widget.userState.currentOrganisationId,
              isDeleted: false,
            );

            var playerTwoTeamB = matchData.playerTwoTeamB != null
                ? UserResponse(
                    id: matchData.playerTwoTeamB!,
                    firstName: matchData.playerTwoTeamBFirstName!,
                    lastName: matchData.playerTwoTeamBLastName!,
                    photoUrl: matchData.playerTwoTeamBPhotoUrl!,
                    email: '',
                    createdAt: DateTime.now(),
                    currentOrganisationId:
                        widget.userState.currentOrganisationId,
                    isDeleted: false,
                  )
                : null;

            var ongoingState = OngoingDoubleFreehandState();
            ongoingState.setTeamOne(
                playerOneTeamA, playerTwoTeamA, matchData.teamAScore);
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
                matchData.teamBScore);

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
                            ),
                            PlayerCard(
                              ongoingDoubleGameObject: ongoingDoubleGameObject,
                              userState: widget.userState,
                              ongoingState: ongoingState,
                              player: playerTwoTeamA,
                              whichPlayer: 'teamOnePlayerTwo',
                              notifyParent: refreshScoreWidget,
                              stopClockFromChild: stopClockFromChild,
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
            return const Center(child: Text('No match data found'));
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
