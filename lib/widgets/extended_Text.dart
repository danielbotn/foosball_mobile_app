import 'package:flutter/material.dart';
import 'package:dano_foosball/state/user_state.dart';
import 'package:dano_foosball/utils/app_color.dart';

class ExtendedText extends StatelessWidget {
  final String text;
  final UserState userState;
  final double? fontSize;
  final Color? colorOverride;
  final bool isBold;
  const ExtendedText(
      {super.key,
      required this.text,
      required this.userState,
      this.fontSize,
      this.colorOverride,
      this.isBold = false});

  @override
  Widget build(BuildContext context) {
    if (colorOverride != null && userState.darkmode == false) {
      return Text(
        text,
        style: TextStyle(
          fontSize: fontSize ?? 16,
          color: colorOverride,
          fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
        ),
      );
    } else {
      return Text(text,
          style: TextStyle(
            color: userState.darkmode ? AppColors.white : AppColors.surfaceDark,
            fontSize: fontSize ?? 16,
            fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
          ));
    }
  }
}
