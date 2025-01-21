import 'package:flutter/material.dart';
import 'package:dano_foosball/state/user_state.dart';
import 'package:dano_foosball/utils/app_color.dart';
import 'package:dano_foosball/widgets/extended_Text.dart';

class Button extends StatefulWidget {
  final UserState userState;
  final Function() onClick;
  final String text;
  final double paddingLeft;
  final double paddingRight;
  final double paddingTop;
  final double paddingBottom;

  const Button({
    super.key,
    required this.userState,
    required this.onClick,
    required this.text,
    required this.paddingBottom,
    required this.paddingLeft,
    required this.paddingRight,
    required this.paddingTop,
  });

  @override
  State<Button> createState() => _ButtonState();
}

class _ButtonState extends State<Button> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          flex: 5,
          child: Padding(
            padding: EdgeInsets.only(
              left: widget.paddingLeft,
              right: widget.paddingRight,
              top: widget.paddingTop,
              bottom: widget.paddingBottom,
            ),
            child: ElevatedButton(
              onPressed: widget.onClick,
              style: ElevatedButton.styleFrom(
                backgroundColor: widget.userState.darkmode
                    ? AppColors.darkModeButtonColor
                    : AppColors.buttonsLightTheme,
                minimumSize: const Size(100, 50),
              ),
              child: ExtendedText(
                text: widget.text,
                userState: widget.userState,
                colorOverride: AppColors.white,
                isBold: true,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
