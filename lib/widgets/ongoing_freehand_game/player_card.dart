import 'package:flutter/material.dart';
import 'package:foosball_mobile_app/models/other/ongoing_game_object.dart';
import 'package:foosball_mobile_app/state/ongoing_freehand_state.dart';
import 'package:foosball_mobile_app/state/user_state.dart';

import '../extended_Text.dart';

class PlayerCard extends StatefulWidget {
  final OngoingGameObject ongoingGameObject;
  final UserState userState;
  final bool isPlayerOne;
  final OngoingFreehandState counter;
  final Function() notifyParent;
  PlayerCard(
      {Key? key,
      required this.ongoingGameObject,
      required this.userState,
      required this.isPlayerOne,
      required this.counter,
      required this.notifyParent
      })
      : super(key: key);

  @override
  State<PlayerCard> createState() => _PlayerCardState();
}

class _PlayerCardState extends State<PlayerCard> {
  @override
  Widget build(BuildContext context) {
  
    void increaseScore() {
      if (widget.isPlayerOne) {
        widget.counter.updatePlayerOneScore(widget.counter.playerOne.score + 1);
      } else {
        widget.counter.updatePlayerTwoScore(widget.counter.playerTwo.score + 1);
      }
      widget.notifyParent();
    }

    return InkWell(
        onTap: () {
          increaseScore();
        },
        child: Padding(
          padding: const EdgeInsets.only(left: 20, top: 10, bottom: 10),
          child: Row(
            children: [
              Column(
                children: [
                  Image.network(
                      widget.isPlayerOne
                          ? widget.ongoingGameObject.playerOne.photoUrl
                          : widget.ongoingGameObject.playerTwo.photoUrl,
                      width: 60,
                      height: 60),
                ],
              ),
              Column(
                children: [
                  ExtendedText(
                      text: widget.isPlayerOne
                          ? widget.ongoingGameObject.playerOne.firstName
                          : widget.ongoingGameObject.playerTwo.firstName,
                      userState: this.widget.userState),
                  ExtendedText(
                      text: widget.isPlayerOne
                          ? widget.ongoingGameObject.playerOne.lastName
                          : widget.ongoingGameObject.playerTwo.lastName,
                      userState: this.widget.userState),
                ],
              ),
            ],
          ),
        ));
  }
}
