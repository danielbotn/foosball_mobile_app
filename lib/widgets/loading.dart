import 'package:flutter/material.dart';
import 'package:foosball_mobile_app/state/user_state.dart';
import 'package:foosball_mobile_app/utils/helpers.dart';
import 'package:loading_indicator/loading_indicator.dart';

class Loading extends StatelessWidget {
  final UserState userState;
  const Loading({Key? key, required this.userState}) : super(key: key);

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
                    colors: [Colors.lightGreen],
                    strokeWidth: 2,
                    pathBackgroundColor: Colors.black))));
  }
}
