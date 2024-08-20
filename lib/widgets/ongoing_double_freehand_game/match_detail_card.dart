import 'package:flutter/material.dart';
import 'package:dano_foosball/models/freehand-double-matches/freehand_double_match_model.dart';
import 'package:dano_foosball/models/user/user_response.dart';
import 'package:dano_foosball/state/user_state.dart';
import '../extended_Text.dart';

class MatchDetailCard extends StatelessWidget {
  final FreehandDoubleMatchModel match;
  final UserResponse player;
  final UserState userState;
  const MatchDetailCard(
      {Key? key,
      required this.match,
      required this.player,
      required this.userState})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 50, top: 10, bottom: 10),
      child: Row(
        children: [
          Column(
            children: [
              Image.network(player.photoUrl, width: 40, height: 40),
            ],
          ),
          Column(
            children: [
              ExtendedText(text: player.firstName, userState: userState),
              ExtendedText(text: player.lastName, userState: userState),
            ],
          ),
        ],
      ),
    );
  }
}
