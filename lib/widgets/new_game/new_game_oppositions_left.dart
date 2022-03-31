import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:foosball_mobile_app/state/new_game_state.dart';
import 'package:foosball_mobile_app/state/user_state.dart';
import 'package:provider/provider.dart';
import '../extended_Text.dart';

class NewGameOppostionsLeft extends StatefulWidget {
  final UserState userState;
  final NewGameState newGameState;
  NewGameOppostionsLeft({Key? key, required this.userState, required this.newGameState}) : super(key: key);

  @override
  State<NewGameOppostionsLeft> createState() => _NewGameOppostionsLeftState();
}

class _NewGameOppostionsLeftState extends State<NewGameOppostionsLeft> {
  @override
  Widget build(BuildContext context) {
    if (widget.newGameState.twoOrFourPlayers) {
        return Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Column(
              children: [
                Row(
                  children: [
                    Visibility(
                      visible: widget.newGameState.playersTeamOne.length > 0,
                      child: Column(
                        children: [
                          Image.network(widget.newGameState.playersTeamOne.length > 0 ? widget.newGameState.playersTeamOne[0].photoUrl : '',
                              width: 60, height: 60),
                        ],
                      ),
                    ),
                    Visibility(
                      visible: widget.newGameState.playersTeamOne.length > 0,
                      child: Column(
                        children: [
                          ExtendedText(
                              text: widget.newGameState.playersTeamOne.length > 0 ? widget.newGameState.playersTeamOne[0].firstName : '',
                              userState: this.widget.userState),
                          ExtendedText(
                              text: widget.newGameState.playersTeamOne.length > 0 ? widget.newGameState.playersTeamOne[0].lastName : '',
                              userState: this.widget.userState),
                        ],
                      ),
                    ),
                  ],
                ),
                
              ],
            ));
      } else {
        if (widget.newGameState.playersTeamOne.length > 0) {
          return Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Column(
              children: [
                Row(
                  children: [
                    Visibility(
                      visible: widget.newGameState.playersTeamOne.length > 0,
                      child: Column(
                        children: [
                          Image.network(widget.newGameState.playersTeamOne.length > 0 ? widget.newGameState.playersTeamOne[0].photoUrl : '',
                              width: 60, height: 60),
                        ],
                      ),
                    ),
                    Visibility(
                      visible: widget.newGameState.playersTeamOne.length > 0,
                      child: Column(
                        children: [
                          ExtendedText(
                              text: widget.newGameState.playersTeamOne.length > 0 ? widget.newGameState.playersTeamOne[0].firstName : '',
                              userState: this.widget.userState),
                          ExtendedText(
                              text: widget.newGameState.playersTeamOne.length > 0 ? widget.newGameState.playersTeamOne[0].lastName : '',
                              userState: this.widget.userState),
                        ],
                      ),
                    ),
                  ],
                ),
                Visibility(
                  visible: widget.newGameState.twoOrFourPlayers == false &&
                      widget.newGameState.playersTeamTwo.length > 0,
                  child: Row(
                    children: [
                      Visibility(
                        visible: true,
                        child: Column(
                          children: [
                            Image.network(
                                widget.newGameState.playersTeamTwo.length > 0 ? widget.newGameState.playersTeamTwo[0].photoUrl : '',
                                width: 60,
                                height: 60),
                          ],
                        ),
                      ),
                      Column(
                        children: [
                          ExtendedText(
                              text: widget.newGameState.playersTeamTwo.length > 0 ? widget.newGameState.playersTeamTwo[0].firstName : '',
                              userState: this.widget.userState),
                          ExtendedText(
                              text: widget.newGameState.playersTeamTwo.length > 0 ? widget.newGameState.playersTeamTwo[0].lastName : '',
                              userState: this.widget.userState),
                        ],
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
  }
}
