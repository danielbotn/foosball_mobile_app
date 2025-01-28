import 'package:dano_foosball/utils/app_color.dart';
import 'package:flutter/material.dart';
import 'package:dano_foosball/state/user_state.dart';
import 'package:dano_foosball/utils/helpers.dart';
import 'package:loading_indicator/loading_indicator.dart';

class Loading extends StatelessWidget {
  final UserState userState;
  const Loading({super.key, required this.userState});

  @override
  Widget build(BuildContext context) {
    Helpers helpers = Helpers();

    bool darkMode = userState.darkmode;
    return Container(
        color: helpers.getBackgroundColor(darkMode),
        child: const Padding(
            padding: EdgeInsets.all(64),
            child: Center(
                child: LoadingIndicator(
                    indicatorType: Indicator.ballPulse,
                    colors: [AppColors.primary],
                    strokeWidth: 2,
                    pathBackgroundColor: Colors.black))));
  }
}
