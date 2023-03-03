import 'package:flutter/material.dart';
import 'package:foosball_mobile_app/api/LeagueApi.dart';
import 'package:foosball_mobile_app/main.dart';
import 'package:foosball_mobile_app/models/leagues/create-league-body.dart';
import 'package:foosball_mobile_app/models/leagues/create-league-response.dart';
import 'package:foosball_mobile_app/state/user_state.dart';
import 'package:foosball_mobile_app/utils/app_color.dart';

class SingleLeagueButton extends StatefulWidget {
  final UserState userState;
  const SingleLeagueButton({Key? key, required this.userState})
      : super(key: key);

  @override
  State<SingleLeagueButton> createState() => _SingleLeagueButtonState();
}

class _SingleLeagueButtonState extends State<SingleLeagueButton> {
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
                onPressed: () => {createSingleLeague()},
                style: ElevatedButton.styleFrom(
                    primary: widget.userState.darkmode
                        ? AppColors.lightThemeShadowColor
                        : AppColors.buttonsLightTheme,
                    minimumSize: const Size(100, 50)),
                child: const Text('Create Single League'),
              ),
            )),
      ],
    );
  }
}
