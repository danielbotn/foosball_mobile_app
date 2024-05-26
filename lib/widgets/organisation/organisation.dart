import 'package:flutter/material.dart';
import '../../state/user_state.dart';
import '../../utils/app_color.dart';
import '../../utils/helpers.dart';
import '../extended_Text.dart';
import '../headline_big.dart';
import 'organisation_card.dart';
import 'Organisations.dart';
import 'organisation_buttons.dart';
import 'organisation_players.dart';

class OrganisationScreen extends StatefulWidget {
  final UserState userState;
  const OrganisationScreen({Key? key, required this.userState})
      : super(key: key);

  @override
  State<OrganisationScreen> createState() => _OrganisationScreenState();
}

class _OrganisationScreenState extends State<OrganisationScreen> {
  // state
  String randomString = '';

  void notifyOrganisations() {
    Helpers helpers = Helpers();
    setState(() {
      randomString = helpers.generateRandomString();
    });
  }

  void notifyOrganisationPlayers() {
    Helpers helpers = Helpers();
    setState(() {
      randomString = helpers.generateRandomString();
    });
  }

  @override
  Widget build(BuildContext context) {
    Helpers helpers = Helpers();
    return Scaffold(
      appBar: AppBar(
        title: ExtendedText(
          text: widget.userState.hardcodedStrings.organisation,
          userState: widget.userState,
        ),
        leading: IconButton(
          icon: const Icon(Icons.chevron_left),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        iconTheme: helpers.getIconTheme(widget.userState.darkmode),
        backgroundColor: helpers.getBackgroundColor(widget.userState.darkmode),
      ),
      body: Container(
        color: widget.userState.darkmode
            ? AppColors.darkModeBackground
            : AppColors.white,
        child: Column(
          children: <Widget>[
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    OrganisationCard(
                        userState: widget.userState,
                        notifyParent: notifyOrganisationPlayers),
                    HeadlineBig(
                        headline: widget.userState.hardcodedStrings.players,
                        userState: widget.userState,
                        fontSize: 20,
                        paddingLeft: 10),
                    SizedBox(
                      height: 215,
                      child: OrganisationPlayers(
                          userState: widget.userState,
                          randomString: randomString),
                    ),
                    HeadlineBig(
                        headline:
                            widget.userState.hardcodedStrings.organisations,
                        userState: widget.userState,
                        fontSize: 20,
                        paddingLeft: 10),
                    SizedBox(
                      height: 215,
                      child: Organisations(
                        userState: widget.userState,
                        randomString: randomString,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            OrganisationButtons(
              userState: widget.userState,
              notifyOrganisation: notifyOrganisations,
            ),
          ],
        ),
      ),
    );
  }
}
