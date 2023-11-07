import 'package:flutter/material.dart';
import 'package:foosball_mobile_app/models/leagues/get-league-response.dart';
import 'package:foosball_mobile_app/state/user_state.dart';
import 'package:foosball_mobile_app/utils/app_color.dart';
import 'package:foosball_mobile_app/utils/helpers.dart';
import 'package:foosball_mobile_app/widgets/extended_Text.dart';

class DoubleLeagueOverview extends StatefulWidget {
  final UserState userState;
  final GetLeagueResponse leagueData;
  const DoubleLeagueOverview(
      {super.key, required this.userState, required this.leagueData});

  @override
  State<DoubleLeagueOverview> createState() => _DoubleLeagueOverviewState();
}

class _DoubleLeagueOverviewState extends State<DoubleLeagueOverview>
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
          text: widget.leagueData.name,
          userState: widget.userState,
          colorOverride:
              widget.userState.darkmode ? AppColors.white : AppColors.textBlack,
        ),
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(
                child: ExtendedText(
              text: widget.userState.hardcodedStrings.standings,
              userState: widget.userState,
            )),
            Tab(
                child: ExtendedText(
              text: widget.userState.hardcodedStrings.fixtures,
              userState: widget.userState,
            )),
          ],
        ),
      ),
      body: Theme(
        data: darkMode ? ThemeData.dark() : ThemeData.light(),
        child: TabBarView(
          controller: _tabController,
          children: const [Text('standings'), Text('fixtures')],
        ),
      ),
    );
  }
}
