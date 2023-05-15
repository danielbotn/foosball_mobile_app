import 'package:flutter/material.dart';
import 'package:foosball_mobile_app/models/leagues/get-league-response.dart';
import 'package:foosball_mobile_app/state/user_state.dart';

class AddDoubleLeagueTeams extends StatefulWidget {
  final UserState userState;
  final GetLeagueResponse leagueData;
  const AddDoubleLeagueTeams(
      {super.key, required this.userState, required this.leagueData});

  @override
  State<AddDoubleLeagueTeams> createState() => _AddDoubleLeagueTeamsState();
}

class _AddDoubleLeagueTeamsState extends State<AddDoubleLeagueTeams> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
