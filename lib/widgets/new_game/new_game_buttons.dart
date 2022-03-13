import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:foosball_mobile_app/state/new_game_state.dart';
import 'package:foosball_mobile_app/state/user_state.dart';
import 'package:foosball_mobile_app/utils/app_color.dart';
import 'package:foosball_mobile_app/utils/helpers.dart';
import 'package:provider/provider.dart';

class NewGameButtons extends StatefulWidget {
  final UserState userState;
  NewGameButtons({Key? key, required this.userState}) : super(key: key);

  @override
  State<NewGameButtons> createState() => _NewGameButtonsState();
}

class _NewGameButtonsState extends State<NewGameButtons> {
  // state variables
  bool isTwoPlayersLocal = false;
  @override
  Widget build(BuildContext context) {
    final newGameState = Provider.of<NewGameState>(context, listen: false);
    bool isTwoPlayers = newGameState.twoOrFourPlayers;
    Helpers helpers = Helpers();

    return Observer(
      builder: (_) {
        return Row(
          children: <Widget>[
            Expanded(
                flex: 5,
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 40.0, right: 40.0, top: 10.0, bottom: 10.0),
                  child: Container(
                    child: ElevatedButton(
                      onPressed: () => {
                        newGameState.clearState(),
                        newGameState.setTwoOrFourPlayers(!isTwoPlayers),
                        newGameState.setAllCheckedPlayersToFalse(newGameState.checkedPlayers.length),
                        // set state
                        setState(() {
                          isTwoPlayersLocal = !isTwoPlayersLocal;
                        })
                      },
                      child: Text(
                          this.widget.userState.hardcodedStrings.twoPlayers),
                      style: ElevatedButton.styleFrom(
                          onPrimary: helpers.getButtonTextColor(
                              this.widget.userState.darkmode, isTwoPlayersLocal),
                          primary: helpers.getNewGameButtonColor(
                              this.widget.userState.darkmode, isTwoPlayersLocal),
                          minimumSize: Size(80, 40)),
                    ),
                  ),
                )),
            Expanded(
                flex: 5,
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 40.0, right: 40.0, top: 10.0, bottom: 10.0),
                  child: Container(
                    child: ElevatedButton(
                      onPressed: () => {
                        newGameState.clearState(),
                        newGameState.setTwoOrFourPlayers(!isTwoPlayers),
                        newGameState.setAllCheckedPlayersToFalse(newGameState.checkedPlayers.length),
                        // set state
                        setState(() {
                          isTwoPlayersLocal = !isTwoPlayersLocal;
                        })
                      },
                      child: Text(
                          this.widget.userState.hardcodedStrings.fourPlayers),
                      style: ElevatedButton.styleFrom(
                          onPrimary: helpers.getButtonTextColor(
                              this.widget.userState.darkmode, !isTwoPlayersLocal),
                          primary: helpers.getNewGameButtonColor(
                              this.widget.userState.darkmode, !isTwoPlayersLocal),
                          minimumSize: Size(80, 40)),
                    ),
                  ),
                )),
          ],
        );
      },
    );
  }
}
