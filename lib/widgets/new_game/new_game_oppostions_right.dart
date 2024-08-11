import 'package:flutter/material.dart';
import 'package:dano_foosball/state/new_game_state.dart';
import 'package:dano_foosball/state/user_state.dart';
import '../extended_Text.dart';

class NewGameOppostionsRight extends StatefulWidget {
  final UserState userState;
  final NewGameState newGameState;
  const NewGameOppostionsRight(
      {Key? key, required this.userState, required this.newGameState})
      : super(key: key);

  @override
  State<NewGameOppostionsRight> createState() => _NewGameOppostionsRightState();
}

class _NewGameOppostionsRightState extends State<NewGameOppostionsRight> {
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
                    visible: widget.newGameState.playersTeamTwo.isNotEmpty,
                    child: Column(
                      children: [
                        ExtendedText(
                            text: widget.newGameState.playersTeamTwo.isNotEmpty
                                ? widget
                                    .newGameState.playersTeamTwo[0].firstName
                                : '',
                            userState: widget.userState),
                        ExtendedText(
                            text: widget.newGameState.playersTeamTwo.isNotEmpty
                                ? widget.newGameState.playersTeamTwo[0].lastName
                                : '',
                            userState: widget.userState),
                      ],
                    ),
                  ),
                  Visibility(
                    visible: widget.newGameState.playersTeamTwo.isNotEmpty,
                    child: Column(
                      children: [
                        Image.network(
                            widget.newGameState.playersTeamTwo.isNotEmpty
                                ? widget.newGameState.playersTeamTwo[0].photoUrl
                                : '',
                            width: 60,
                            height: 60),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ));
    } else {
      if (widget.newGameState.playersTeamOne.isNotEmpty) {
        return Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Column(
              children: [
                Row(
                  children: [
                    Visibility(
                      visible: widget.newGameState.playersTeamOne.length > 1,
                      child: Column(
                        children: [
                          ExtendedText(
                              text:
                                  widget.newGameState.playersTeamOne.length > 1
                                      ? widget.newGameState.playersTeamOne[1]
                                          .firstName
                                      : '',
                              userState: widget.userState),
                          ExtendedText(
                              text:
                                  widget.newGameState.playersTeamOne.length > 1
                                      ? widget.newGameState.playersTeamOne[1]
                                          .lastName
                                      : '',
                              userState: widget.userState),
                        ],
                      ),
                    ),
                    Visibility(
                      visible: widget.newGameState.playersTeamOne.length > 1,
                      child: Column(
                        children: [
                          Image.network(
                              widget.newGameState.playersTeamOne.length > 1
                                  ? widget
                                      .newGameState.playersTeamOne[1].photoUrl
                                  : '',
                              width: 60,
                              height: 60),
                        ],
                      ),
                    ),
                  ],
                ),
                Visibility(
                  visible: widget.newGameState.twoOrFourPlayers == false &&
                      widget.newGameState.playersTeamTwo.length > 1,
                  child: Row(
                    children: [
                      Column(
                        children: [
                          ExtendedText(
                              text:
                                  widget.newGameState.playersTeamTwo.length > 1
                                      ? widget.newGameState.playersTeamTwo[1]
                                          .firstName
                                      : '',
                              userState: widget.userState),
                          ExtendedText(
                              text:
                                  widget.newGameState.playersTeamTwo.length > 1
                                      ? widget.newGameState.playersTeamTwo[1]
                                          .lastName
                                      : '',
                              userState: widget.userState),
                        ],
                      ),
                      Visibility(
                        visible: true,
                        child: Column(
                          children: [
                            Image.network(
                                widget.newGameState.playersTeamTwo.length > 1
                                    ? widget
                                        .newGameState.playersTeamTwo[1].photoUrl
                                    : '',
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
  }
}
