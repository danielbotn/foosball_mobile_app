import 'package:flutter/material.dart';
import 'package:foosball_mobile_app/main.dart';
import 'package:foosball_mobile_app/state/user_state.dart';
import 'package:foosball_mobile_app/utils/app_color.dart';
import 'package:foosball_mobile_app/utils/helpers.dart';
import 'package:foosball_mobile_app/widgets/extended_Text.dart';
import 'package:foosball_mobile_app/widgets/league/button/LeagueButton.dart';
import 'package:foosball_mobile_app/widgets/league/dashbaord/LeagueDashboard.dart';

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
          backgroundColor:
              helpers.getBackgroundColor(widget.userState.darkmode),
          title: ExtendedText(
            text: userState.hardcodedStrings.league,
            userState: userState,
            colorOverride:
                userState.darkmode ? AppColors.white : AppColors.textBlack,
          ),
        ),
        body: Theme(
            data: darkMode ? ThemeData.dark() : ThemeData.light(),
            child: Container(
                color:
                    darkMode ? AppColors.darkModeBackground : AppColors.white,
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Expanded(
                            flex: 1,
                            child: SizedBox(
                              height: 400,
                              child: LeagueDashboard(
                                userState: userState,
                                randomNumber: randomNumber,
                              ),
                            )),
                      ],
                    ),
                    const Spacer(),
                    Visibility(
                        visible: showButton,
                        child: LeagueButton(
                          userState: userState,
                          newLeaugeCreated: updateLeagueList,
                          hideButton: hideButton,
                        ))
                  ],
                ))));
  }
}
