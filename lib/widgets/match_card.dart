import 'package:flutter/material.dart';
import 'package:foosball_mobile_app/state/user_state.dart';

import 'extended_Text.dart';

class MatchCard extends StatelessWidget {
  final UserState userState;
  final String userFirstName, userLastName, userPhotoUrl;
  final bool lefOrRight;
  final double? widthAndHeight;

  const MatchCard(
      {Key? key,
      required this.userState,
      required this.userFirstName,
      required this.userLastName,
      required this.userPhotoUrl,
      required this.lefOrRight,
      this.widthAndHeight})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(left: 20),
        child: Column(
          children: [
            Row(
              children: [
                Visibility(
                  visible: lefOrRight,
                  child: Column(
                    children: [
                      Image.network(userPhotoUrl,
                          width: widthAndHeight ?? 80,
                          height: widthAndHeight ?? 80),
                    ],
                  ),
                ),
                Column(
                  children: [
                    ExtendedText(text: userFirstName, userState: userState),
                    ExtendedText(text: userLastName, userState: userState),
                  ],
                ),
                Visibility(
                  visible: lefOrRight == false,
                  child: Column(
                    children: [
                      Image.network(userPhotoUrl,
                          width: widthAndHeight ?? 80,
                          height: widthAndHeight ?? 80),
                    ],
                  ),
                ),
              ],
            )
          ],
        ));
  }
}
