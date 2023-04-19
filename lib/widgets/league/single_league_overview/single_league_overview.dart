import 'package:flutter/material.dart';
import 'package:foosball_mobile_app/state/user_state.dart';
import 'package:foosball_mobile_app/utils/app_color.dart';
import 'package:foosball_mobile_app/utils/helpers.dart';
import 'package:foosball_mobile_app/widgets/extended_Text.dart';
import 'package:foosball_mobile_app/widgets/league/single_league_fixtures/single_league_fixtures.dart';
import 'package:foosball_mobile_app/widgets/league/single_league_standings/single_league_standings.dart';

class SingleLeagueOverview extends StatefulWidget {
  final UserState userState;
  final int leagueId;
  const SingleLeagueOverview(
      {super.key, required this.userState, required this.leagueId});

  @override
  State<SingleLeagueOverview> createState() => _SingleLeagueOverviewState();
}

class _SingleLeagueOverviewState extends State<SingleLeagueOverview>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
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
            Navigator.pop(context);
          },
        ),
        iconTheme: helpers.getIconTheme(widget.userState.darkmode),
        backgroundColor: helpers.getBackgroundColor(widget.userState.darkmode),
        title: ExtendedText(
          text: widget.userState.hardcodedStrings.league,
          userState: widget.userState,
          colorOverride:
              widget.userState.darkmode ? AppColors.white : AppColors.textBlack,
        ),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Standings'),
            Tab(text: 'Fixtures'),
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
              leagueId: widget.leagueId,
            ),
            SingleLeagueFixtures(
              userState: widget.userState,
              leagueId: widget.leagueId,
            ),
          ],
        ),
      ),
    );
  }
}

class FixturesTab extends StatelessWidget {
  const FixturesTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Fixtures'),
    );
  }
}
