import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:foosball_mobile_app/state/new_game_state.dart';
import 'package:foosball_mobile_app/state/user_state.dart';
import 'package:foosball_mobile_app/utils/helpers.dart';
import 'package:provider/provider.dart';

class NewGameButtons extends StatefulWidget {
  final UserState userState;
  final Function() notifyParent;
  NewGameButtons(
      {Key? key, required this.userState, required this.notifyParent})
      : super(key: key);

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

    void fourPlayersClicked() {
      newGameState.setTwoOrFourPlayers(!isTwoPlayers);
      // set state
      setState(() {
        isTwoPlayersLocal = !isTwoPlayersLocal;
      });

      // if newGameState.playersTeamTwo.length == 1 then add that player to newGameState.playersTeamOne
      // and remove the player from newGameState.playersTeamTwo
      if (newGameState.playersTeamTwo.length == 1) {
        newGameState.addPlayerToTeamOne(newGameState.playersTeamTwo[0]);
        newGameState.removePlayerFromTeamTwo(newGameState.playersTeamTwo[0]);
      }

      this.widget.notifyParent();
    }

    void twoPlayersClicked() {
      newGameState.setTwoOrFourPlayers(!isTwoPlayers);
      // set state
      setState(() {
        isTwoPlayersLocal = !isTwoPlayersLocal;
      });

      // if newGameState.playersTeamOne.length > 1 then remove the last player from newGameState.playersTeamOne
      if (newGameState.playersTeamOne.length > 1) {
        newGameState.setCheckedPlayerToFalseFromUser(newGameState.playersTeamOne[1]);
        newGameState.removePlayerFromTeamOne(newGameState.playersTeamOne[1]);
      }
      if (newGameState.playersTeamTwo.length > 1) {
        newGameState.setCheckedPlayerToFalseFromUser(newGameState.playersTeamTwo[1]);
        newGameState.removePlayerFromTeamOne(newGameState.playersTeamTwo[1]);
      }

      
      this.widget.notifyParent();
    }

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
                      onPressed: () => {twoPlayersClicked()},
                      child: Text(
                          this.widget.userState.hardcodedStrings.twoPlayers),
                      style: ElevatedButton.styleFrom(
                          onPrimary: helpers.getButtonTextColor(
                              this.widget.userState.darkmode,
                              isTwoPlayersLocal),
                          primary: helpers.getNewGameButtonColor(
                              this.widget.userState.darkmode,
                              isTwoPlayersLocal),
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
                      child: Text(
                          this.widget.userState.hardcodedStrings.fourPlayers),
                      style: ElevatedButton.styleFrom(
                          onPrimary: helpers.getButtonTextColor(
                              this.widget.userState.darkmode,
                              !isTwoPlayersLocal),
                          primary: helpers.getNewGameButtonColor(
                              this.widget.userState.darkmode,
                              !isTwoPlayersLocal),
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
