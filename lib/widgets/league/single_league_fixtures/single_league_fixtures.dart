import 'package:dano_foosball/main.dart';
import 'package:dano_foosball/models/other/TwoPlayersObject.dart';
import 'package:dano_foosball/widgets/single_league_history/single_league_match_detail.dart';
import 'package:flutter/material.dart';
import 'package:dano_foosball/api/SingleLeagueMatchApi.dart';
import 'package:dano_foosball/models/single-league-matches/single_league_match_model.dart';
import 'package:dano_foosball/state/user_state.dart';
import 'package:dano_foosball/utils/helpers.dart';
import 'package:dano_foosball/widgets/UI/Error/ServerError.dart';
import 'package:dano_foosball/widgets/league/ongoing_game/ongoing_game.dart';
import 'package:dano_foosball/widgets/loading.dart';

class SingleLeagueFixtures extends StatefulWidget {
  final UserState userState;
  final int leagueId;
  final bool showOnlyMyFixtures; // New parameter

  const SingleLeagueFixtures({
    super.key,
    required this.userState,
    required this.leagueId,
    this.showOnlyMyFixtures = false, // Default value
  });

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
        result = userState.hardcodedStrings.matchPaused;
      }
    }
    return result;
  }

  void goToGame(SingleLeagueMatchModel? matchData) {
    if (matchData != null) {
      if (matchData.matchStarted == false &&
          (matchData.playerOne == widget.userState.userInfoGlobal.userId ||
              matchData.playerTwo == widget.userState.userInfoGlobal.userId)) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => OngoingGame(
              userState: widget.userState,
              matchModel: matchData,
            ),
          ),
        );
      } else if (matchData.matchEnded == true) {
        TwoPlayersObject tpo = TwoPlayersObject(
            userState: widget.userState,
            typeOfMatch: "single_league_matchs",
            matchId: matchData.id,
            leagueId: matchData.leagueId);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SingleLeagueMatchDetail(
              twoPlayersObject: tpo,
            ),
          ),
        );
      }
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

          // Apply filtering if showOnlyMyFixtures is true
          if (widget.showOnlyMyFixtures) {
            int userId = widget.userState.userInfoGlobal.userId;
            data = data
                ?.where((match) =>
                    match.playerOne == userId || match.playerTwo == userId)
                .toList();
          }

          if (data == null || data.isEmpty) {
            return const Center(child: Text('No fixtures available.'));
          }

          return Container(
            color: helpers.getBackgroundColor(widget.userState.darkmode),
            height: double.infinity,
            child: ListView.builder(
              itemCount: data.length,
              itemBuilder: (BuildContext context, int index) {
                final match = data![index];

                final matchKey =
                    '${match.playerOneFirstName} ${match.playerOneLastName} vs ${match.playerTwoFirstName} ${match.playerTwoLastName} (${match.id})';
                return ListTile(
                  key: Key('match_$index'),
                  onTap: () => goToGame(match),
                  leading: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CircleAvatar(
                        backgroundImage: NetworkImage(match.playerOnePhotoUrl),
                      ),
                      const SizedBox(width: 16),
                      CircleAvatar(
                        backgroundImage: NetworkImage(match.playerTwoPhotoUrl),
                      ),
                    ],
                  ),
                  title: Text(
                    key: Key(matchKey),
                    '${match.playerOneFirstName} ${match.playerOneLastName} vs ${match.playerTwoFirstName} ${match.playerTwoLastName}',
                  ),
                  subtitle: Text(
                    getSubtitle(match),
                    key: Key('${getSubtitle(match)}_${match.id}'),
                  ),
                );
              },
            ),
          );
        } else if (snapshot.hasError) {
          return ServerError(userState: widget.userState);
        } else {
          return const Text('No data found');
        }
      },
    );
  }
}
