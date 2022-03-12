import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:foosball_mobile_app/state/new_game_state.dart';
import 'package:foosball_mobile_app/state/user_state.dart';
import 'package:provider/provider.dart';
import '../extended_Text.dart';

class NewGameOppostionsRight extends StatefulWidget {
  final UserState userState;
  NewGameOppostionsRight({Key? key, required this.userState}) : super(key: key);

  @override
  State<NewGameOppostionsRight> createState() => _NewGameOppostionsRightState();
}

class _NewGameOppostionsRightState extends State<NewGameOppostionsRight> {
  @override
  Widget build(BuildContext context) {
    return Observer(builder: (_) {
      final newGameState = Provider.of<NewGameState>(context, listen: false);
      if (newGameState.twoOrFourPlayers) {
        return Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Column(
              children: [
                Row(
                  children: [
                    Visibility(
                      visible: newGameState.playersTeamTwo.length > 0,
                      child: Column(
                        children: [
                          ExtendedText(
                              text: newGameState.playersTeamTwo.length > 0 ? newGameState.playersTeamTwo[0].firstName : '',
                              userState: this.widget.userState),
                          ExtendedText(
                              text: newGameState.playersTeamTwo.length > 0 ? newGameState.playersTeamTwo[0].lastName : '',
                              userState: this.widget.userState),
                        ],
                      ),
                    ),
                    Visibility(
                      visible: newGameState.playersTeamTwo.length > 0,
                      child: Column(
                        children: [
                          Image.network(newGameState.playersTeamTwo.length > 0 ? newGameState.playersTeamTwo[0].photoUrl : '',
                              width: 60, height: 60),
                        ],
                      ),
                    ),
                  ],
                ),
                
              ],
            ));
      } else {
        if (newGameState.playersTeamOne.length > 0) {
          return Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Column(
              children: [
                Row(
                  children: [
                     Visibility(
                      visible: newGameState.playersTeamOne.length > 1,
                      child: Column(
                        children: [
                          ExtendedText(
                              text: newGameState.playersTeamOne.length > 1 ? newGameState.playersTeamOne[1].firstName : '',
                              userState: this.widget.userState),
                          ExtendedText(
                              text: newGameState.playersTeamOne.length > 1 ? newGameState.playersTeamOne[1].lastName : '',
                              userState: this.widget.userState),
                        ],
                      ),
                    ),
                    Visibility(
                      visible: newGameState.playersTeamOne.length > 1,
                      child: Column(
                        children: [
                          Image.network(newGameState.playersTeamOne.length > 1 ? newGameState.playersTeamOne[1].photoUrl : '',
                              width: 60, height: 60),
                        ],
                      ),
                    ),
                   
                  ],
                ),
                Visibility(
                  visible: newGameState.twoOrFourPlayers == false &&
                      newGameState.playersTeamTwo.length > 1,
                  child: Row(
                    children: [
                     
                      Column(
                        children: [
                          ExtendedText(
                              text: newGameState.playersTeamTwo.length > 1 ? newGameState.playersTeamTwo[1].firstName : '',
                              userState: this.widget.userState),
                          ExtendedText(
                              text: newGameState.playersTeamTwo.length > 1 ? newGameState.playersTeamTwo[1].lastName : '',
                              userState: this.widget.userState),
                        ],
                      ),
                       Visibility(
                        visible: true,
                        child: Column(
                          children: [
                            Image.network(
                                newGameState.playersTeamTwo.length > 1 ? newGameState.playersTeamTwo[1].photoUrl : '',
                                width: 60,
                                height: 60),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ));
        } else {
          return Container();
        }
        
      }
    });
  }
}
