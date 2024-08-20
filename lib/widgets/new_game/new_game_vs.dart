import 'package:flutter/material.dart';
import 'package:dano_foosball/main.dart';
import 'package:dano_foosball/state/new_game_state.dart';
import 'package:dano_foosball/widgets/extended_Text.dart';

class NewGameVs extends StatelessWidget {
  final NewGameState newGameState;
  const NewGameVs({Key? key, required this.newGameState}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Visibility(
        visible: newGameState.playersTeamOne.isNotEmpty &&
            newGameState.playersTeamTwo.isNotEmpty,
        child: ExtendedText(text: 'VS', userState: userState));
  }
}
