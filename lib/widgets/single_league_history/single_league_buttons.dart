import 'package:flutter/material.dart';
import 'package:dano_foosball/state/user_state.dart';
import 'package:dano_foosball/utils/app_color.dart';
import 'package:dano_foosball/widgets/extended_Text.dart';

class SingleLeagueButtons extends StatelessWidget {
  final UserState userState;

  const SingleLeagueButtons({super.key, required this.userState});

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
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: close,
              style: ElevatedButton.styleFrom(
                backgroundColor: userState.darkmode
                    ? AppColors.darkModeButtonColor
                    : AppColors.buttonsLightTheme,
                minimumSize: const Size(100, 50),
              ),
              child: ExtendedText(
                text: userState.hardcodedStrings.close,
                userState: userState,
                colorOverride: Colors.white,
                isBold: true,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
