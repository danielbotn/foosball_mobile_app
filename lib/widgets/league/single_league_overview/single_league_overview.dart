import 'package:dano_foosball/main.dart';
import 'package:dano_foosball/widgets/dashboard/New_Dashboard.dart';
import 'package:flutter/material.dart';
import 'package:dano_foosball/models/leagues/get-league-response.dart';
import 'package:dano_foosball/state/user_state.dart';
import 'package:dano_foosball/utils/app_color.dart';
import 'package:dano_foosball/utils/helpers.dart';
import 'package:dano_foosball/widgets/extended_Text.dart';
import 'package:dano_foosball/widgets/league/single_league_fixtures/single_league_fixtures.dart';
import 'package:dano_foosball/widgets/league/single_league_standings/single_league_standings.dart';

class SingleLeagueOverview extends StatefulWidget {
  final UserState userState;
  final GetLeagueResponse leagueData;
  final bool leagueNewlyCreated; // New parameter
  const SingleLeagueOverview(
      {super.key,
      required this.userState,
      required this.leagueData,
      this.leagueNewlyCreated = false});

  @override
  State<SingleLeagueOverview> createState() => _SingleLeagueOverviewState();
}

class _SingleLeagueOverviewState extends State<SingleLeagueOverview>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool darkMode = widget.userState.darkmode;
    Helpers helpers = Helpers();
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.chevron_left),
          onPressed: () {
            if (widget.leagueNewlyCreated == false) {
              Navigator.pop(context);
            } else {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => NewDashboard(
                    userState: widget.userState,
                  ),
                ),
              );
            }
          },
        ),
        iconTheme: helpers.getIconTheme(widget.userState.darkmode),
        backgroundColor: helpers.getBackgroundColor(widget.userState.darkmode),
        title: ExtendedText(
          text: widget.leagueData.name,
          userState: widget.userState,
          colorOverride: widget.userState.darkmode
              ? AppColors.white
              : AppColors.surfaceDark,
        ),
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(
              key: const Key(
                  'tab_standings'), // Added a key to the Standings tab
              child: ExtendedText(
                text: widget.userState.hardcodedStrings.standings,
                userState: widget.userState,
              ),
            ),
            Tab(
              key: const Key(
                  'tab_my_fixtures'), // Added a key to the My Fixtures tab
              child: ExtendedText(
                text: userState.hardcodedStrings.myFixtures,
                userState: widget.userState,
              ),
            ),
            Tab(
              key: const Key(
                  'tab_all_fixtures'), // Added a key to the All Fixtures tab
              child: ExtendedText(
                text: userState.hardcodedStrings.allFixtures,
                userState: widget.userState,
              ),
            ),
          ],
        ),
      ),
      body: Theme(
        data: darkMode ? ThemeData.dark() : ThemeData.light(),
        child: TabBarView(
          controller: _tabController,
          children: [
            SingleLeagueStandings(
              userState: widget.userState,
              leagueId: widget.leagueData.id,
            ),
            SingleLeagueFixtures(
              userState: widget.userState,
              leagueId: widget.leagueData.id,
              showOnlyMyFixtures: true,
            ),
            SingleLeagueFixtures(
              userState: widget.userState,
              leagueId: widget.leagueData.id,
            ),
          ],
        ),
      ),
    );
  }
}
