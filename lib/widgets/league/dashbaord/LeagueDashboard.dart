import 'package:flutter/material.dart';
import 'package:dano_foosball/api/LeagueApi.dart';
import 'package:dano_foosball/main.dart';
import 'package:dano_foosball/state/user_state.dart';
import 'package:dano_foosball/utils/app_color.dart';
import 'package:dano_foosball/widgets/UI/Error/ServerError.dart';
import 'package:dano_foosball/widgets/emptyData/emptyData.dart';
import 'package:dano_foosball/widgets/league/league_list/league_list.dart';
import 'package:dano_foosball/widgets/loading.dart';

import '../../../models/leagues/get-league-response.dart';

class LeagueDashboard extends StatefulWidget {
  final UserState userState;
  final String randomNumber;
  const LeagueDashboard(
      {super.key, required this.userState, required this.randomNumber});

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
    if (widget.userState.currentOrganisationId == 0) {
      // If currentOrganisationId is 0, return an empty list immediately
      return [];
    } else {
      // Otherwise, proceed with the API call
      LeagueApi lapi = LeagueApi();
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
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: FutureBuilder(
        future: Future.wait([leaguesFuture]),
        builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Loading(
                userState: widget.userState); // Display loading widget
          } else if (snapshot.hasError) {
            // Handle error case
            return ServerError(userState: widget.userState);
          } else if (snapshot.hasData) {
            // Check if leaguesFuture data is empty
            List<GetLeagueResponse>? leagueData = snapshot.data![0];

            if (leagueData == null || leagueData.isEmpty) {
              // Display message if data is empty
              return Center(
                child: EmptyData(
                    userState: widget.userState,
                    message: widget.userState.hardcodedStrings.noData,
                    iconData: Icons.error),
              );
            } else {
              // Data is available, build UI with the data
              return FutureBuilder(
                future: leaguesFuture,
                builder: (context,
                    AsyncSnapshot<List<GetLeagueResponse>?> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Loading(userState: widget.userState);
                  } else if (snapshot.hasError) {
                    return ServerError(userState: widget.userState);
                  } else if (snapshot.hasData) {
                    return Container(
                      color: widget.userState.darkmode
                          ? AppColors.darkModeLighterBackground
                          : AppColors.white,
                      child: LeagueList(
                        userState: userState,
                        data: leaguelist,
                        randomNumber: widget.randomNumber,
                        onLeagueDeleted: (league) {
                          leaguesFuture = getLeagues();
                        },
                      ),
                    );
                  } else {
                    // Default case, show an empty container
                    return Container();
                  }
                },
              );
            }
          } else {
            // Default case, show an empty container
            return Container();
          }
        },
      ),
    );
  }
}
