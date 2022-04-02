import 'package:flutter/material.dart';
import 'package:foosball_mobile_app/models/freehand-matches/freehand_match_model.dart';
import 'package:foosball_mobile_app/state/user_state.dart';
import '../extended_Text.dart';

class MatchDetailCard extends StatelessWidget {
  final FreehandMatchModel match;
  final bool isPlayerOne;
  final UserState userState;
  const MatchDetailCard(
      {Key? key,
      required this.match,
      required this.isPlayerOne,
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
              Image.network(
                  isPlayerOne
                      ? match.playerOnePhotoUrl
                      : match.playerTwoPhotoUrl,
                  width: 60,
                  height: 60),
            ],
          ),
          Column(
            children: [
              ExtendedText(
                  text: isPlayerOne
                      ? match.playerOneFirstName
                      : match.playerTwoFirstName,
                  userState: userState),
              ExtendedText(
                  text: isPlayerOne
                      ? match.playerOneLastName
                      : match.playerTwoLastName,
                  userState: userState),
            ],
          ),
        ],
      ),
    );
  }
}
