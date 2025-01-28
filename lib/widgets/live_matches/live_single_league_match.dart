import 'package:dano_foosball/api/SingleLeagueMatchApi.dart';
import 'package:dano_foosball/main.dart';
import 'package:dano_foosball/models/single-league-matches/single_league_match_model.dart';
import 'package:dano_foosball/models/user/user_response.dart';
import 'package:dano_foosball/state/user_state.dart';
import 'package:dano_foosball/utils/app_color.dart';
import 'package:dano_foosball/widgets/UI/Error/ServerError.dart';
import 'package:dano_foosball/widgets/emptyData/emptyData.dart';
import 'package:dano_foosball/widgets/extended_Text.dart';
import 'package:dano_foosball/widgets/league/ongoing_game/player_card/playerCard.dart';
import 'package:dano_foosball/widgets/league/ongoing_game/player_score/player_score.dart';
import 'package:dano_foosball/widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:signalr_netcore/signalr_client.dart' as signalr;
import 'package:dano_foosball/utils/helpers.dart';
import 'package:dano_foosball/models/live-matches/match.dart';

class LiveSingleLeagueMatch extends StatefulWidget {
  final UserState userState;
  final signalr.HubConnection hubConnection; // Receive the hub connection
  final int matchId;

  const LiveSingleLeagueMatch({
    super.key,
    required this.userState,
    required this.hubConnection,
    required this.matchId,
  });

  @override
  State<LiveSingleLeagueMatch> createState() => _LiveSingleLeagueMatchState();
}

class _LiveSingleLeagueMatchState extends State<LiveSingleLeagueMatch> {
  late Future<SingleLeagueMatchModel?> _matchFuture;
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

  int playerOneScore = 0;
  int playerTwoScore = 0;

  @override
  void initState() {
    super.initState();
    _matchFuture = _fetchMatchData();

    widget.hubConnection.on('SendLiveMatches', _handleScoreUpdateTest);
  }

  Future<SingleLeagueMatchModel?> _fetchMatchData() async {
    SingleLeagueMatchApi api = SingleLeagueMatchApi();
    var data = await api.getSingleLeagueMatchById(widget.matchId);
    if (data != null) {
      UserResponse tmpPlayerOne = UserResponse(
          id: data.playerOne,
          email: '',
          firstName: data.playerOneFirstName,
          lastName: data.playerOneLastName,
          createdAt: DateTime.now(),
          currentOrganisationId: widget.userState.currentOrganisationId,
          photoUrl: data.playerOnePhotoUrl,
          isDeleted: false);

      UserResponse tmpPlayerTwo = UserResponse(
          id: data.playerTwo,
          email: '',
          firstName: data.playerTwoFirstName,
          lastName: data.playerTwoLastName,
          createdAt: DateTime.now(),
          currentOrganisationId: widget.userState.currentOrganisationId,
          photoUrl: data.playerTwoPhotoUrl,
          isDeleted: false);
      setState(() {
        playerOne = tmpPlayerOne;
        playerTwo = tmpPlayerTwo;
        playerOneScore = data.playerOneScore!.toInt();
        playerTwoScore = data.playerTwoScore!.toInt();
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

  void _handleScoreUpdateTest(List<Object?>? message) {
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
          playerOneScore = updatedMatch.userScore;
          playerTwoScore = updatedMatch.opponentUserOrTeamScore;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    Helpers helpers = Helpers();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Live Match',
          style: TextStyle(
            color: widget.userState.darkmode
                ? AppColors.white
                : AppColors.surfaceDark,
          ),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.chevron_left,
            color:
                widget.userState.darkmode ? AppColors.white : Colors.grey[700],
          ),
          onPressed: () {
            Navigator.pop(context, widget.userState);
          },
        ),
        backgroundColor: widget.userState.darkmode
            ? AppColors.darkModeBackground
            : AppColors.white,
        iconTheme: IconThemeData(
            color:
                widget.userState.darkmode ? AppColors.white : Colors.grey[700]),
      ),
      body: FutureBuilder<SingleLeagueMatchModel?>(
        future: _matchFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Loading(userState: widget.userState);
          } else if (snapshot.hasError) {
            return ServerError(
              userState: widget.userState,
            );
          } else if (!snapshot.hasData) {
            return EmptyData(
                userState: widget.userState,
                message: 'Match data not available',
                iconData: Icons.person_off_sharp);
          } else {
            return Container(
              color: widget.userState.darkmode
                  ? AppColors.darkModeBackground
                  : AppColors.white,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 1,
                        child: PlayerCard(
                          userState: widget.userState,
                          isPlayerOne: true,
                          player: playerOne,
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
                      // ignore: prefer_interpolation_to_compose_strings
                      Expanded(
                        flex: 1,
                        child: PlayerCard(
                          userState: widget.userState,
                          isPlayerOne: false,
                          player: playerTwo,
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
