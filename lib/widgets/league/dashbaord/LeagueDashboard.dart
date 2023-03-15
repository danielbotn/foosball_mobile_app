import 'package:flutter/material.dart';
import 'package:foosball_mobile_app/api/LeagueApi.dart';
import 'package:foosball_mobile_app/main.dart';
import 'package:foosball_mobile_app/state/user_state.dart';
import 'package:foosball_mobile_app/utils/app_color.dart';
import 'package:foosball_mobile_app/widgets/league/league_list/league_list.dart';

import '../../../models/leagues/get-league-response.dart';

class LeagueDashboard extends StatefulWidget {
  final UserState userState;
  final String randomNumber;
  const LeagueDashboard(
      {Key? key, required this.userState, required this.randomNumber})
      : super(key: key);

  @override
  State<LeagueDashboard> createState() => _LeagueDashboardState();
}

class _LeagueDashboardState extends State<LeagueDashboard> {
  late Future<List<GetLeagueResponse>?> leaguesFuture;
  List<GetLeagueResponse?> leaguelist = [];

  @override
  void initState() {
    super.initState();
    leaguesFuture = getLeagues();
  }

  @override
  void didUpdateWidget(LeagueDashboard old) {
    super.didUpdateWidget(old);
    leaguesFuture = getLeagues();
  }

  Future<List<GetLeagueResponse>?> getLeagues() async {
    LeagueApi lapi = LeagueApi(token: widget.userState.token);
    var leagues = await lapi
        .getLeaguesByOrganisationId(widget.userState.currentOrganisationId);

    if (mounted) {
      setState(() {
        leaguelist = [];
      });

      if (leagues != null) {
        setState(() {
          leaguelist.addAll(leagues);
        });
      }
    }

    return leagues;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future.wait([leaguesFuture]),
      builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
        if (snapshot.hasData) {
          return FutureBuilder(
            future: leaguesFuture,
            builder:
                (context, AsyncSnapshot<List<GetLeagueResponse>?> snapshot) {
              if (snapshot.hasData) {
                return Container(
                  color: widget.userState.darkmode
                      ? AppColors.darkModeBackground
                      : AppColors.white,
                  child: Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                              flex: 1,
                              child: SizedBox(
                                height: 310,
                                child: LeagueList(
                                  userState: userState,
                                  data: leaguelist,
                                  randomNumber: widget.randomNumber,
                                ),
                              )),
                        ],
                      ),
                    ],
                  ),
                );
              } else {
                return const CircularProgressIndicator();
              }
            },
          );
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }
}
