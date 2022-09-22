import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';

class Loading extends StatelessWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Padding(
        padding: EdgeInsets.all(64),
        child: Center(
            child: LoadingIndicator(
                indicatorType: Indicator.ballPulse,
                colors: [Colors.lightGreen],
                strokeWidth: 2,
                pathBackgroundColor: Colors.black)));
  }
}
