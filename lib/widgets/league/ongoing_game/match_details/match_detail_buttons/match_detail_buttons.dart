import 'package:flutter/material.dart';
import 'package:foosball_mobile_app/state/user_state.dart';
import 'package:foosball_mobile_app/utils/app_color.dart';
import 'package:foosball_mobile_app/widgets/dashboard/New_Dashboard.dart';
import 'package:foosball_mobile_app/widgets/extended_Text.dart';

class MatchDetailButtons extends StatelessWidget {
  final UserState userState;
  const MatchDetailButtons({super.key, required this.userState});

  @override
  Widget build(BuildContext context) {
    void close() {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => NewDashboard(
                    userState: userState,
                  )));
    }

    return Row(
      children: <Widget>[
        Expanded(
            flex: 5,
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: ElevatedButton(
                onPressed: () => {close()},
                style: ElevatedButton.styleFrom(
                    primary: userState.darkmode
                        ? AppColors.lightThemeShadowColor
                        : AppColors.buttonsLightTheme,
                    minimumSize: const Size(100, 50)),
                child: ExtendedText(
                    text: userState.hardcodedStrings.close,
                    userState: userState,
                    colorOverride: AppColors.white),
              ),
            )),
      ],
    );
  }
}
