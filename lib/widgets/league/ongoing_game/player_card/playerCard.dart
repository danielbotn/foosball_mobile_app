import 'package:flutter/material.dart';
import 'package:dano_foosball/models/user/user_response.dart';
import 'package:dano_foosball/state/user_state.dart';
import 'package:dano_foosball/widgets/extended_Text.dart';

class PlayerCard extends StatefulWidget {
  final UserState userState;
  final UserResponse player;
  final bool isPlayerOne;
  const PlayerCard(
      {super.key,
      required this.userState,
      required this.player,
      required this.isPlayerOne});

  @override
  State<PlayerCard> createState() => _PlayerCardState();
}

class _PlayerCardState extends State<PlayerCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, top: 10, bottom: 10),
      child: Row(
        children: [
          Column(
            children: [
              Image.network(widget.player.photoUrl, width: 60, height: 60),
            ],
          ),
          Column(
            children: [
              ExtendedText(
                  text: widget.player.firstName, userState: widget.userState),
              ExtendedText(
                  text: widget.player.lastName, userState: widget.userState),
            ],
          ),
        ],
      ),
    );
  }
}
