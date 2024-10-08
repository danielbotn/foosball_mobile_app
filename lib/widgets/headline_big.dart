import 'package:flutter/material.dart';
import 'package:dano_foosball/state/user_state.dart';
import 'package:dano_foosball/utils/helpers.dart';
import 'package:dano_foosball/widgets/extended_Text.dart';

class HeadlineBig extends StatelessWidget {
  final UserState userState;
  final String headline;
  final double fontSize;
  final double? paddingLeft;
  const HeadlineBig(
      {super.key,
      required this.headline,
      required this.userState,
      required this.fontSize,
      this.paddingLeft});

  @override
  Widget build(BuildContext context) {
    double paddingIsLeft = paddingLeft ?? 10;
    Helpers helpers = Helpers();

    return Container(
      padding: const EdgeInsets.all(8),
      height: 48,
      color: helpers.getBackgroundColor(userState.darkmode),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Align(
              alignment: Alignment.centerLeft,
              child: Container(
                  margin: EdgeInsets.only(left: paddingIsLeft),
                  child: ExtendedText(
                    text: headline,
                    userState: userState,
                    fontSize: fontSize,
                  )),
            ),
          ),
        ],
      ),
    );
  }
}
