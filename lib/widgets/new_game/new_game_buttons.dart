import 'package:flutter/material.dart';
import 'package:dano_foosball/state/new_game_state.dart';
import 'package:dano_foosball/state/user_state.dart';
import 'package:dano_foosball/utils/helpers.dart';

class NewGameButtons extends StatefulWidget {
  final UserState userState;
  final Function() notifyParent;
  final NewGameState newGameState;

  const NewGameButtons({
    Key? key,
    required this.userState,
    required this.notifyParent,
    required this.newGameState,
  }) : super(key: key);

  @override
  State<NewGameButtons> createState() => _NewGameButtonsState();
}

class _NewGameButtonsState extends State<NewGameButtons> {
  bool isTwoPlayersLocal = false;

  @override
  Widget build(BuildContext context) {
    bool isTwoPlayers = widget.newGameState.twoOrFourPlayers;
    Helpers helpers = Helpers();

    void fourPlayersClicked() {
      widget.newGameState.setTwoOrFourPlayers(!isTwoPlayers);
      setState(() {
        isTwoPlayersLocal = !isTwoPlayersLocal;
      });

      widget.newGameState.clearState(widget.userState.userId);
      widget.notifyParent();
    }

    void twoPlayersClicked() {
      widget.newGameState.setTwoOrFourPlayers(!isTwoPlayers);
      setState(() {
        isTwoPlayersLocal = !isTwoPlayersLocal;
      });

      widget.newGameState.clearState(widget.userState.userId);
      widget.notifyParent();
    }

    return Row(
      children: <Widget>[
        Expanded(
          flex: 5,
          child: Padding(
            padding: const EdgeInsets.only(
                left: 40.0, right: 40.0, top: 10.0, bottom: 10.0),
            child: ElevatedButton(
              onPressed: twoPlayersClicked,
              style: ElevatedButton.styleFrom(
                foregroundColor: helpers.getButtonTextColor(
                    widget.userState.darkmode, isTwoPlayersLocal),
                backgroundColor: helpers.getNewGameButtonColor(
                    widget.userState.darkmode, isTwoPlayersLocal),
                minimumSize: const Size(80, 40),
              ),
              child: Text(widget.userState.hardcodedStrings.twoPlayers),
            ),
          ),
        ),
        Expanded(
          flex: 5,
          child: Padding(
            padding: const EdgeInsets.only(
                left: 40.0, right: 40.0, top: 10.0, bottom: 10.0),
            child: ElevatedButton(
              onPressed: fourPlayersClicked,
              style: ElevatedButton.styleFrom(
                foregroundColor: helpers.getButtonTextColor(
                    widget.userState.darkmode, !isTwoPlayersLocal),
                backgroundColor: helpers.getNewGameButtonColor(
                    widget.userState.darkmode, !isTwoPlayersLocal),
                minimumSize: const Size(80, 40),
              ),
              child: Text(widget.userState.hardcodedStrings.fourPlayers),
            ),
          ),
        ),
      ],
    );
  }
}
