import 'package:flutter/material.dart';
import 'package:foosball_mobile_app/state/user_state.dart';
import 'package:foosball_mobile_app/utils/app_color.dart';

class FreehandDoubleMatchButtons extends StatelessWidget {
  final UserState userState;
  const FreehandDoubleMatchButtons({Key? key, required this.userState})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
            flex: 5,
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Container(
                child: ElevatedButton(
                  onPressed: () => {},
                  child: Text(userState.hardcodedStrings.newMatch),
                  style: ElevatedButton.styleFrom(
                      primary: userState.darkmode ? AppColors.lightThemeShadowColor : AppColors.buttonsLightTheme,
                      minimumSize: Size(100, 50)),
                ),
              ),
            )),
        Expanded(
            flex: 5,
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Container(
                child: ElevatedButton(
                  onPressed: () => {},
                  child: Text(userState.hardcodedStrings.rematch),
                  style: ElevatedButton.styleFrom(
                      primary: userState.darkmode ? AppColors.lightThemeShadowColor : AppColors.buttonsLightTheme,
                      minimumSize: Size(100, 50)),
                ),
              ),
            )),
      ],
    );
  }
}
