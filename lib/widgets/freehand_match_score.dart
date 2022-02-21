import 'package:flutter/material.dart';
import 'package:foosball_mobile_app/state/user_state.dart';
import 'package:foosball_mobile_app/utils/app_color.dart';

class FreehandMatchScore extends StatelessWidget {
  final UserState userState;
  final String userScore;

  const FreehandMatchScore({
    Key? key,
    required this.userState,
    required this.userScore,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(1.0),
        child: Column(
          children: [
            Row(
              children: [
                Column(
                  children: [
                    Text(userScore,
                        style: TextStyle(
                          color: this.userState.darkmode
                              ? AppColors.white
                              : AppColors.textBlack,
                          fontSize: 40,
                        )),
                  ],
                ),
              ],
            )
          ],
        ));
  }
}
