import 'package:flutter/material.dart';
import 'package:dano_foosball/models/leagues/get-league-response.dart';
import 'package:dano_foosball/state/user_state.dart';
import 'package:dano_foosball/utils/app_color.dart';
import 'package:dano_foosball/widgets/extended_Text.dart';
import 'package:dano_foosball/widgets/league/add_double_league_teams/add_double_league_teams.dart';
import 'package:dano_foosball/widgets/league/add_league_players/add_league_players.dart';
import 'package:dano_foosball/widgets/league/double_league_overview/double_league_overview.dart';
import 'package:dano_foosball/widgets/league/single_league_overview/single_league_overview.dart';

class LeagueList extends StatelessWidget {
  final UserState userState;
  final String randomNumber;
  final List<GetLeagueResponse?>? data;

  const LeagueList(
      {Key? key,
      required this.userState,
      this.data,
      required this.randomNumber})
      : super(key: key);

  void handleLeagueTap(BuildContext context, GetLeagueResponse leagueData) {
    // Implement the logic for what should happen when a league is tapped
    if (leagueData.hasLeagueStarted == false && leagueData.typeOfLeague == 0) {
      // go to add players screen
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => AddLeaguePlayers(
                    userState: userState,
                    leagueData: leagueData,
                  )));
    } else if (leagueData.hasLeagueStarted == true &&
        leagueData.typeOfLeague == 0) {
      //
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => SingleLeagueOverview(
                    userState: userState,
                    leagueData: leagueData,
                  )));
    } else if (leagueData.hasLeagueStarted == false &&
        leagueData.typeOfLeague == 1) {
      // danni
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => AddDoubleLeagueTeams(
                    userState: userState,
                    leagueData: leagueData,
                  )));
    } else if (leagueData.hasLeagueStarted == true &&
        leagueData.typeOfLeague == 1) {
      // go to double league overview page
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => DoubleLeagueOverview(
                    userState: userState,
                    leagueData: leagueData,
                  )));
    }
  }

  @override
  Widget build(BuildContext context) {
    if (data == null || data!.isEmpty) {
      return const SizedBox();
    }

    // Filter the data list
    final filteredData = data!.where((league) {
      if (league == null) return false;
      return !(league.hasLeagueStarted == true && league.hasAccess == false);
    }).toList();

    if (filteredData.isEmpty) {
      return const SizedBox();
    }

    return SafeArea(
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: filteredData.length,
        itemBuilder: (context, index) {
          final league = filteredData[index];
          if (league == null) {
            return const SizedBox();
          }

          Icon leagueIcon = league.typeOfLeague == 0
              ? Icon(Icons.person,
                  color: userState.darkmode ? AppColors.white : null)
              : Icon(Icons.people,
                  color: userState.darkmode ? AppColors.white : null);

          String subtitleText;
          if (league.hasLeagueStarted) {
            subtitleText = league.hasLeagueEnded!
                ? userState.hardcodedStrings.finished
                : userState.hardcodedStrings.ongoing;
          } else {
            subtitleText = userState.hardcodedStrings.notStarted;
          }

          return ListTile(
            onTap: () => handleLeagueTap(context, league),
            leading: leagueIcon,
            title: ExtendedText(
              text: league.name,
              userState: userState,
            ),
            subtitle: Text(subtitleText),
          );
        },
      ),
    );
  }
}
