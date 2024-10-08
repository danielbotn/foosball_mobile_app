import 'package:flutter/material.dart';
import 'package:dano_foosball/state/user_state.dart';
import 'package:dano_foosball/utils/app_color.dart';
import 'package:dano_foosball/utils/helpers.dart';
import 'package:dano_foosball/widgets/extended_Text.dart';
import 'package:dano_foosball/widgets/league/button/LeagueButton.dart';
import 'package:dano_foosball/widgets/league/dashbaord/LeagueDashboard.dart';

class League extends StatefulWidget {
  final UserState userState;
  const League({Key? key, required this.userState}) : super(key: key);

  @override
  State<League> createState() => _LeagueState();
}

class _LeagueState extends State<League> {
  // state
  String randomNumber = "";
  bool showButton = true;

  void updateLeagueList() {
    Helpers helpers = Helpers();
    setState(() {
      randomNumber = helpers.generateRandomString();
    });
  }

  void hideButton() {
    setState(() {
      showButton = !showButton;
    });
  }

  @override
  Widget build(BuildContext context) {
    bool darkMode = widget.userState.darkmode;
    Helpers helpers = Helpers();
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
      ),
      body: Theme(
        data: darkMode ? ThemeData.dark() : ThemeData.light(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            LeagueDashboard(
              userState: widget.userState,
              randomNumber: randomNumber,
            ),
            Visibility(
              visible:
                  showButton && widget.userState.currentOrganisationId != 0,
              child: LeagueButton(
                userState: widget.userState,
                newLeaugeCreated: updateLeagueList,
                hideButton: hideButton,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
