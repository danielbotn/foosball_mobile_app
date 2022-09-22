import 'package:flutter/material.dart';
import 'package:foosball_mobile_app/state/new_game_state.dart';
import 'package:foosball_mobile_app/state/user_state.dart';
import 'package:foosball_mobile_app/utils/helpers.dart';
import 'package:foosball_mobile_app/widgets/extended_Text.dart';

class HeadlineBigTeammatesOpponents extends StatelessWidget {
  final UserState userState;
  final double fontSize;
  final double? paddingLeft;
  final String randomString;
  final NewGameState newGameState;
  const HeadlineBigTeammatesOpponents(
      {super.key,
      required this.userState,
      required this.fontSize,
      this.paddingLeft,
      required this.randomString,
      required this.newGameState});

  @override
  Widget build(BuildContext context) {
    double paddingIsLeft = paddingLeft ?? 10;
    Helpers helpers = Helpers();
    String headlineString = '';
    if (newGameState.twoOrFourPlayers) {
      headlineString = userState.hardcodedStrings.chooseOpponent;
    } else {
      if (newGameState.playersTeamOne.isEmpty) {
        headlineString = userState.hardcodedStrings.chooseTeammate;
      } else {
        if (newGameState.playersTeamOne.length < 2) {
          headlineString = userState.hardcodedStrings.chooseTeammate;
        } else {
          headlineString = userState.hardcodedStrings.chooseOpponents;
        }
      }
    }
    return Container(
      padding: const EdgeInsets.all(8),
      height: 48,
      color: helpers.getBackgroundColor(userState.darkmode),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Align(
              alignment: Alignment.centerLeft,
              child: Container(
                  margin: EdgeInsets.only(left: paddingIsLeft),
                  child: ExtendedText(
                    text: headlineString,
                    userState: userState,
                    fontSize: fontSize,
                  )),
            ),
          ),
        ],
      ),
    );
  }
}
