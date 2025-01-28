import 'package:flutter/material.dart';
import 'package:dano_foosball/state/user_state.dart';
import 'package:dano_foosball/utils/app_color.dart';
import 'package:dano_foosball/widgets/Settings.dart';
import 'package:dano_foosball/widgets/history.dart';
import 'package:dano_foosball/widgets/organisation/organisation.dart';

import '../new_game/new_game.dart';

class QuicActions extends StatelessWidget {
  final UserState userState;
  final Function() notifyParent;
  const QuicActions(
      {super.key, required this.userState, required this.notifyParent});

  @override
  Widget build(BuildContext context) {
    goToNewGame(BuildContext context) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => NewGame(
                    userState: userState,
                  )));
    }

    goToHistory(BuildContext context) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => History(
                    userState: userState,
                  )));
    }

    goToSettings(BuildContext context) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => Settings(
                    userState: userState,
                  ))).then(((value) {
        notifyParent();
      }));
    }

    goToOrganisation(BuildContext context) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => OrganisationScreen(
                    userState: userState,
                  )));
    }

    return Container(
        color:
            userState.darkmode ? AppColors.darkModeBackground : AppColors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              children: [
                InkWell(
                  key: const Key('newGameButton'),
                  onTap: () {
                    goToNewGame(context);
                  },
                  child: Container(
                      margin: const EdgeInsets.all(3.0),
                      height: 60,
                      width: 50,
                      color: AppColors.primary,
                      alignment: Alignment.center,
                      child: const Icon(Icons.play_circle_filled_rounded,
                          color: Colors.white)),
                ),
                InkWell(
                  onTap: () {
                    goToHistory(context);
                  },
                  child: Container(
                      margin: const EdgeInsets.all(3.0),
                      height: 60,
                      width: 50,
                      color: AppColors.primary,
                      alignment: Alignment.center,
                      child: const Icon(Icons.history, color: Colors.white)),
                ),
                InkWell(
                  onTap: () {
                    goToOrganisation(context);
                  },
                  child: Container(
                      margin: const EdgeInsets.all(3.0),
                      height: 60,
                      width: 50,
                      color: AppColors.primary,
                      alignment: Alignment.center,
                      child: const Icon(Icons.groups, color: Colors.white)),
                ),
                InkWell(
                  onTap: () {
                    goToSettings(context);
                  },
                  child: Container(
                      margin: const EdgeInsets.all(3.0),
                      height: 60,
                      width: 50,
                      color: AppColors.primary,
                      alignment: Alignment.center,
                      child: const Icon(Icons.settings, color: Colors.white)),
                ),
              ],
            )
          ],
        ));
  }
}
