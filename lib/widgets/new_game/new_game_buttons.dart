import 'package:flutter/material.dart';
import 'package:foosball_mobile_app/state/new_game_state.dart';
import 'package:foosball_mobile_app/state/user_state.dart';
import 'package:foosball_mobile_app/utils/helpers.dart';

class NewGameButtons extends StatefulWidget {
  final UserState userState;
  final Function() notifyParent;
  final NewGameState newGameState;
  NewGameButtons(
      {Key? key,
      required this.userState,
      required this.notifyParent,
      required this.newGameState})
      : super(key: key);

  @override
  State<NewGameButtons> createState() => _NewGameButtonsState();
}

class _NewGameButtonsState extends State<NewGameButtons> {
  // state variables
  bool isTwoPlayersLocal = false;
  @override
  Widget build(BuildContext context) {
    bool isTwoPlayers = widget.newGameState.twoOrFourPlayers;
    Helpers helpers = Helpers();

    void fourPlayersClicked() {
      widget.newGameState.setTwoOrFourPlayers(!isTwoPlayers);
      // set state
      setState(() {
        isTwoPlayersLocal = !isTwoPlayersLocal;
      });

      widget.newGameState.clearState(widget.userState.userId);
      this.widget.notifyParent();
    }

    void twoPlayersClicked() {
      widget.newGameState.setTwoOrFourPlayers(!isTwoPlayers);
      // set state
      setState(() {
        isTwoPlayersLocal = !isTwoPlayersLocal;
      });

      widget.newGameState.clearState(widget.userState.userId);

      this.widget.notifyParent();
    }

    return Row(
      children: <Widget>[
        Expanded(
            flex: 5,
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 40.0, right: 40.0, top: 10.0, bottom: 10.0),
              child: Container(
                child: ElevatedButton(
                  onPressed: () => {twoPlayersClicked()},
                  child:
                      Text(this.widget.userState.hardcodedStrings.twoPlayers),
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
                    fourPlayersClicked(),
                  },
                  child:
                      Text(this.widget.userState.hardcodedStrings.fourPlayers),
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
  }
}
