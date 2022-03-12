import 'package:flutter/material.dart';
import 'package:foosball_mobile_app/state/user_state.dart';
import 'package:foosball_mobile_app/utils/app_color.dart';

class ExtendedText extends StatelessWidget {
  final String text;
  final UserState userState;
  final double? fontSize;
  final Color? colorOverride;
  const ExtendedText({Key? key, required this.text, required this.userState, this.fontSize, this.colorOverride}) 
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (colorOverride != null && userState.darkmode == false) {
      return Text(
        text,
        style: TextStyle(
          fontSize: fontSize ?? 16,
          color: colorOverride
        ),
      );
    } else {
      return Text(text,
          style: TextStyle(
            color:
                this.userState.darkmode ? AppColors.white : AppColors.textBlack,
            fontSize: fontSize != null ? fontSize : 16,
          ));
    }
  }
}
