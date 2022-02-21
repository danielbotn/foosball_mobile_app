import 'package:flutter/material.dart';
import 'package:foosball_mobile_app/state/user_state.dart';
import 'package:foosball_mobile_app/utils/app_color.dart';

class FreehandMatchCard extends StatelessWidget {
  final UserState userState;
  final String userFirstName, userLastName, userPhotoUrl;
  final bool lefOrRight;
  const FreehandMatchCard(
      {Key? key,
      required this.userState,
      required this.userFirstName,
      required this.userLastName,
      required this.userPhotoUrl,
      required this.lefOrRight})
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
                  Image.network(userPhotoUrl, width: 80, height: 80),
                ],
              ),
            ),
            Column(
              children: [
                Text(userFirstName,
                    style: TextStyle(
                        color: this.userState.darkmode
                            ? AppColors.white
                            : AppColors.textBlack)),
                Text(userLastName,
                    style: TextStyle(
                        color: this.userState.darkmode
                            ? AppColors.white
                            : AppColors.textBlack)),
              ],
            ),
            Visibility(
              visible: lefOrRight == false,
              child: Column(
                children: [
                  Image.network(userPhotoUrl, width: 80, height: 80),
                ],
              ),
            ),
          ],
        )
      ],
    )
    );
  }
}

