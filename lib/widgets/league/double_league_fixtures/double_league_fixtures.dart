import 'package:flutter/material.dart';
import 'package:dano_foosball/api/DoubleLeagueMatchApi.dart';
import 'package:dano_foosball/main.dart';
import 'package:dano_foosball/models/double-league-matches/double_league_match_model.dart';
import 'package:dano_foosball/state/user_state.dart';
import 'package:dano_foosball/utils/helpers.dart';
import 'package:dano_foosball/widgets/UI/Error/ServerError.dart';
import 'package:dano_foosball/widgets/league/ongoing_double_game/ongoing_double_game.dart';
import 'package:dano_foosball/widgets/loading.dart';

class DoubleLeagueFixtures extends StatefulWidget {
  final UserState userState;
  final int leagueId;
  final bool showOnlyMyFixtures;
  const DoubleLeagueFixtures(
      {super.key,
      required this.userState,
      required this.leagueId,
      this.showOnlyMyFixtures = false});

  @override
  State<DoubleLeagueFixtures> createState() => _DoubleLeagueFixturesState();
}

class _DoubleLeagueFixturesState extends State<DoubleLeagueFixtures> {
  late Future<List<DoubleLeagueMatchModel>?> _future;

  @override
  void initState() {
    super.initState();
    _future = DoubleLeagueMatchApi()
        .getAllDoubleLeagueMatchesByLeagueId(widget.leagueId);
  }

  String getSubtitle(DoubleLeagueMatchModel? match) {
    String result = "";

    if (match != null) {
      if (match.matchEnded == true) {
        result = "${match.teamOneScore}-${match.teamTwoScore}";
      } else if (match.matchStarted == false) {
        result = widget.userState.hardcodedStrings.notStarted;
      } else if (match.matchPaused == true) {
        result = userState.hardcodedStrings.matchPaused;
      }
    }
    return result;
  }

  void goToGame(DoubleLeagueMatchModel? matchData) {
    if ((matchData!.teamOne[0].userId == widget.userState.userId ||
            matchData.teamOne[1].userId == widget.userState.userId ||
            matchData.teamTwo[0].userId == widget.userState.userId ||
            matchData.teamTwo[1].userId == widget.userState.userId) &&
        matchData.matchStarted == false) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => OngoingDoubleGame(
                  userState: userState, matchModel: matchData)));
    }
  }

  @override
  Widget build(BuildContext context) {
    Helpers helpers = Helpers();
    return FutureBuilder<List<DoubleLeagueMatchModel>?>(
      future: _future,
      builder: (BuildContext context,
          AsyncSnapshot<List<DoubleLeagueMatchModel>?> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Loading(
            userState: widget.userState,
          );
        }
        if (snapshot.hasData) {
          List<DoubleLeagueMatchModel>? data = snapshot.data;

          if (widget.showOnlyMyFixtures) {
            data = data
                ?.where((match) =>
                    match.teamOne
                        .any((p) => p.userId == widget.userState.userId) ||
                    match.teamTwo
                        .any((p) => p.userId == widget.userState.userId))
                .toList();
          }

          return Container(
              color: helpers.getBackgroundColor(widget.userState.darkmode),
              height: double.infinity,
              child: ListView.builder(
                itemCount: data?.length,
                itemBuilder: (BuildContext context, int index) {
                  DoubleLeagueMatchModel? match = data?[index];
                  return ListTile(
                    onTap: () => {goToGame(match)},
                    leading: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CircleAvatar(
                          backgroundImage:
                              NetworkImage(match?.teamOne[0].photoUrl ?? ''),
                        ),
                        const SizedBox(width: 16),
                        CircleAvatar(
                          backgroundImage:
                              NetworkImage(match?.teamTwo[0].photoUrl ?? ''),
                        ),
                      ],
                    ),
                    title: Text(
                      '${match?.teamOne[0].teamName ?? 'No team name'} vs ${match?.teamTwo[0].teamName ?? 'No team name'}',
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
