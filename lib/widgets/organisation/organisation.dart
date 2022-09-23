import 'package:flutter/material.dart';
import 'package:foosball_mobile_app/main.dart';

import '../../state/user_state.dart';
import '../../utils/app_color.dart';
import '../../utils/helpers.dart';
import '../extended_Text.dart';
import '../headline_big.dart';
import 'OrganisationCard.dart';
import 'Organisations.dart';
import 'organisation_players.dart';

class OrganisationScreen extends StatefulWidget {
  final UserState userState;
  const OrganisationScreen({Key? key, required this.userState})
      : super(key: key);

  @override
  State<OrganisationScreen> createState() => _OrganisationScreenState();
}

class _OrganisationScreenState extends State<OrganisationScreen> {
  @override
  Widget build(BuildContext context) {
    Helpers helpers = Helpers();
    return Scaffold(
        appBar: AppBar(
            title: ExtendedText(
                text: widget.userState.hardcodedStrings.organisation,
                userState: widget.userState),
            leading: IconButton(
              icon: const Icon(Icons.chevron_left),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            iconTheme: helpers.getIconTheme(widget.userState.darkmode),
            backgroundColor:
                helpers.getBackgroundColor(widget.userState.darkmode)),
        body: Container(
          color: widget.userState.darkmode
              ? AppColors.darkModeBackground
              : AppColors.white,
          child: Column(
            children: <Widget>[
              OrganisationCard(userState: userState),
              HeadlineBig(
                  headline: userState.hardcodedStrings.players,
                  userState: userState,
                  fontSize: 20,
                  paddingLeft: 10),
              SizedBox(
                  height: 215,
                  child: OrganisationPlayers(userState: userState)),
              HeadlineBig(
                  headline: userState.hardcodedStrings.organisations,
                  userState: userState,
                  fontSize: 20,
                  paddingLeft: 10),
              // SizedBox(height: 215, child: Organisations(userState: userState)),
            ],
          ),
        ));
  }
}