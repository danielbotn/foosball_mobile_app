import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:foosball_mobile_app/main.dart';
import 'package:foosball_mobile_app/state/new_game_state.dart';
import 'package:foosball_mobile_app/widgets/extended_Text.dart';
import 'package:provider/provider.dart';

class NewGameVs extends StatelessWidget {
  const NewGameVs({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (_) {
       final newGameState = Provider.of<NewGameState>(context, listen: false);
      return Visibility(
          visible: newGameState.playersTeamOne.length > 0 && newGameState.playersTeamTwo.length > 0,
          child: Container(
            child: ExtendedText(text: 'VS', userState: userState),
          ));
    });
  }
}
