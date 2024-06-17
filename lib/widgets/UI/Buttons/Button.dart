import 'package:flutter/material.dart';
import 'package:foosball_mobile_app/state/user_state.dart';
import 'package:foosball_mobile_app/utils/app_color.dart';

class Button extends StatefulWidget {
  final UserState userState;
  final Function() onClick;
  final String text;
  final double paddingLeft;
  final double paddingRight;
  final double paddingTop;
  final double paddingBottom;

  const Button({
    Key? key,
    required this.userState,
    required this.onClick,
    required this.text,
    required this.paddingBottom,
    required this.paddingLeft,
    required this.paddingRight,
    required this.paddingTop,
  }) : super(key: key);

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
              onPressed: () => widget.onClick(),
              style: ElevatedButton.styleFrom(
                primary: widget.userState.darkmode
                    ? AppColors.darkModeButtonColor
                    : AppColors.buttonsLightTheme,
                minimumSize: const Size(100, 50),
              ),
              child: Text(widget.text),
            ),
          ),
        ),
      ],
    );
  }
}
