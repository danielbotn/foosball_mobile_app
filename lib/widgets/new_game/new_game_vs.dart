import 'package:flutter/material.dart';
import 'package:foosball_mobile_app/main.dart';
import 'package:foosball_mobile_app/state/new_game_state.dart';
import 'package:foosball_mobile_app/widgets/extended_Text.dart';

class NewGameVs extends StatelessWidget {
  final NewGameState newGameState;
  const NewGameVs({Key? key, required this.newGameState}) : super(key: key);

  @override
  Widget build(BuildContext context) {
     return Visibility(
          visible: newGameState.playersTeamOne.length > 0 && newGameState.playersTeamTwo.length > 0,
          child: Container(
            child: ExtendedText(text: 'VS', userState: userState),
          ));
  }
}
