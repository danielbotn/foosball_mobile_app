import 'package:flutter/material.dart';
import 'package:dano_foosball/api/SingleLeagueMatchApi.dart';
import 'package:dano_foosball/main.dart';
import 'package:dano_foosball/models/single-league-matches/single_league_match_model.dart';
import 'package:dano_foosball/state/user_state.dart';
import 'package:dano_foosball/utils/helpers.dart';
import 'package:dano_foosball/widgets/UI/Error/ServerError.dart';
import 'package:dano_foosball/widgets/league/ongoing_game/ongoing_game.dart';
import 'package:dano_foosball/widgets/loading.dart';

class SingleLeagueFixtures extends StatefulWidget {
  final UserState userState;
  final int leagueId;
  const SingleLeagueFixtures(
      {super.key, required this.userState, required this.leagueId});

  @override
  State<SingleLeagueFixtures> createState() => _SingleLeagueFixturesState();
}

class _SingleLeagueFixturesState extends State<SingleLeagueFixtures> {
  late Future<List<SingleLeagueMatchModel>?> _future;

  @override
  void initState() {
    super.initState();
    _future = SingleLeagueMatchApi()
        .getAllSingleLeagueMatchesByLeagueId(widget.leagueId);
  }

  String getSubtitle(SingleLeagueMatchModel? match) {
    String result = "";

    if (match != null) {
      if (match.matchEnded == true) {
        result = "${match.playerOneScore}-${match.playerTwoScore}";
      } else if (match.matchStarted == false) {
        result = widget.userState.hardcodedStrings.notStarted;
      } else if (match.matchPaused == true) {
        result = "Match Paused";
      }
    }
    return result;
  }

  void goToGame(SingleLeagueMatchModel? matchData) {
    if (matchData?.playerOne == widget.userState.userId ||
        matchData?.playerTwo == widget.userState.userId &&
            matchData?.matchStarted == false) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  OngoingGame(userState: userState, matchModel: matchData)));
    }
  }

  @override
  Widget build(BuildContext context) {
    Helpers helpers = Helpers();
    return FutureBuilder<List<SingleLeagueMatchModel>?>(
      future: _future,
      builder: (BuildContext context,
          AsyncSnapshot<List<SingleLeagueMatchModel>?> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Loading(
            userState: widget.userState,
          );
        }
        if (snapshot.hasData) {
          List<SingleLeagueMatchModel>? data = snapshot.data;
          return Container(
              color: helpers.getBackgroundColor(widget.userState.darkmode),
              height: double.infinity,
              child: ListView.builder(
                itemCount: data?.length,
                itemBuilder: (BuildContext context, int index) {
                  SingleLeagueMatchModel? match = data?[index];
                  return ListTile(
                    onTap: () => {goToGame(match)},
                    leading: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CircleAvatar(
                          backgroundImage:
                              NetworkImage(match?.playerOnePhotoUrl ?? ''),
                        ),
                        const SizedBox(width: 16),
                        CircleAvatar(
                          backgroundImage:
                              NetworkImage(match?.playerTwoPhotoUrl ?? ''),
                        ),
                      ],
                    ),
                    title: Text(
                      '${match?.playerOneFirstName ?? 'No first name'} ${match?.playerOneLastName ?? 'No last name'} vs ${match?.playerTwoFirstName ?? 'No first name'} ${match?.playerTwoLastName ?? 'No last name'}',
                    ),
                    subtitle: Text(getSubtitle(match)),
                  );
                },
              ));
        } else if (snapshot.hasError) {
          return ServerError(userState: widget.userState);
        } else {
          return const Text('No data found');
        }
      },
    );
  }
}
