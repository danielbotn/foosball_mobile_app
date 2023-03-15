import 'package:flutter/material.dart';
import 'package:foosball_mobile_app/api/LeagueApi.dart';
import 'package:foosball_mobile_app/main.dart';
import 'package:foosball_mobile_app/models/leagues/create-league-body.dart';
import 'package:foosball_mobile_app/models/leagues/create-league-response.dart';
import 'package:foosball_mobile_app/state/user_state.dart';
import 'package:foosball_mobile_app/utils/app_color.dart';
import 'package:foosball_mobile_app/widgets/inputs/InputWidget.dart';

class LeagueButton extends StatefulWidget {
  final UserState userState;
  const LeagueButton({Key? key, required this.userState}) : super(key: key);

  @override
  State<LeagueButton> createState() => _LeagueButtonState();
}

class _LeagueButtonState extends State<LeagueButton> {
  // state
  String leagueName = "";

  // set state of leagueName
  void setLeagueName(String name) {
    setState(() {
      leagueName = name;
    });
  }

  Future<void> createLeaguePopup(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Fyrirsögn eitt"),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                InputWidget(
                  userState: widget.userState,
                  onChangeInput: setLeagueName,
                  clearInputText: false,
                  hintText: "League name",
                )
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(widget.userState.hardcodedStrings.cancel),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text(widget.userState.hardcodedStrings.create),
              onPressed: () {
                Navigator.of(context).pop();
                // deleteMatch();
              },
            ),
          ],
        );
      },
    );
  }

  Future createSingleLeague() async {
    LeagueApi api = LeagueApi(token: userState.token);

    // Create payload
    CreateLeagueBody payload = CreateLeagueBody(
        name: "",
        typeOfLeague: 1,
        upTo: 10,
        organisationId: 1,
        howManyRounds: 2);

    CreateLeagueResponse? response = await api.createLeague(payload);

    if (response != null) {
    } else {
      // error
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
            flex: 5,
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: ElevatedButton(
                onPressed: () => {createLeaguePopup(context)},
                style: ElevatedButton.styleFrom(
                    primary: widget.userState.darkmode
                        ? AppColors.lightThemeShadowColor
                        : AppColors.buttonsLightTheme,
                    minimumSize: const Size(100, 50)),
                child: const Text('Create New League'),
              ),
            )),
      ],
    );
  }
}
