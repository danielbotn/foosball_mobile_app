import 'package:flutter/material.dart';
import 'package:foosball_mobile_app/state/user_state.dart';
import '../extended_Text.dart';

class FreehandDoubleMatchCard extends StatelessWidget {
  final UserState userState;
  final String firstName, lastName, photoUrl;
  final bool lefOrRight;
  const FreehandDoubleMatchCard(
      {Key? key,
      required this.userState,
      required this.firstName,
      required this.lastName,
      required this.photoUrl,
      required this.lefOrRight})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(left: 20, top: 10),
        child: Column(
          children: [
            Row(
              children: [
                Visibility(
                  visible: lefOrRight,
                  child: Column(
                    children: [
                      Image.network(photoUrl, width: 50, height: 50),
                    ],
                  ),
                ),
                Column(
                  children: [
                    ExtendedText(
                        text: firstName, userState: this.userState),
                    ExtendedText(text: lastName, userState: userState),
                  ],
                ),
                Visibility(
                  visible: lefOrRight == false,
                  child: Column(
                    children: [
                      Image.network(photoUrl, width: 50, height: 50),
                    ],
                  ),
                ),
              ],
            )
          ],
        ));
  }
}
