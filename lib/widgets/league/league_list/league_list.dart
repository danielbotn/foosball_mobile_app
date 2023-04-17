import 'package:flutter/material.dart';
import 'package:foosball_mobile_app/models/leagues/get-league-response.dart';
import 'package:foosball_mobile_app/state/user_state.dart';
import 'package:foosball_mobile_app/utils/app_color.dart';
import 'package:foosball_mobile_app/widgets/extended_Text.dart';
import 'package:foosball_mobile_app/widgets/league/add_league_players/add_league_players.dart';
import 'package:foosball_mobile_app/widgets/league/single_league_overview/single_league_overview.dart';

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
                    leagueId: leagueData.id,
                  )));
    }
  }

  @override
  Widget build(BuildContext context) {
    if (data == null || data!.isEmpty) {
      return const SizedBox();
    }

    return SafeArea(
        child: ListView.builder(
      shrinkWrap: true,
      itemCount: data!.length,
      itemBuilder: (context, index) {
        final league = data![index];
        if (league == null) {
          return const SizedBox();
        }

        return ListTile(
          onTap: () => handleLeagueTap(context, league),
          leading: CircleAvatar(
            backgroundColor: userState.darkmode
                ? AppColors.lightThemeShadowColor
                : AppColors.buttonsLightTheme,
            child: ExtendedText(
              text: '${index + 1}',
              userState: userState,
              colorOverride: AppColors.white,
            ),
          ),
          title: ExtendedText(
            text: league.name,
            userState: userState,
          ),
          subtitle: league.hasLeagueStarted ? null : const Text('Not Started'),
        );
      },
    ));
  }
}
