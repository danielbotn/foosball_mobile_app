import 'package:flutter/material.dart';
import 'package:foosball_mobile_app/state/user_state.dart';
import 'package:foosball_mobile_app/utils/app_color.dart';
import 'package:foosball_mobile_app/widgets/extended_Text.dart';

class SingleLeagueButtons extends StatelessWidget {
  final UserState userState;
  const SingleLeagueButtons({Key? key, required this.userState})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    void close() {
      Navigator.pop(context);
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
                  colorOverride: Colors.white,
                ),
              ),
            ))
      ],
    );
  }
}
