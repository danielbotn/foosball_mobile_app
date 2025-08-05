import 'package:dano_foosball/state/user_state.dart';
import 'package:flutter/material.dart';

class FeatureIntroSlider extends StatelessWidget {
  final UserState userState;
  const FeatureIntroSlider({super.key, required this.userState});

  @override
  Widget build(BuildContext context) {
    final bgColor = userState.darkmode ? Colors.black : Colors.white;
    final headlineColor = userState.darkmode ? Colors.white : Colors.black87;
    final subtextColor = userState.darkmode ? Colors.white70 : Colors.black54;

    return Container(
      color: bgColor,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Image at the top
          SizedBox(
            height: 260,
            child: Image.asset(
              'assets/images/foosball_player.png',
              fit: BoxFit.contain,
            ),
          ),

          const SizedBox(height: 24),

          // Big headline
          Text(
            userState.hardcodedStrings.welcomeTextHeadline,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
              color: headlineColor,
            ),
          ),

          const SizedBox(height: 12),

          // Subheadline
          Text(
            userState.hardcodedStrings.welcomeTextBody,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16, color: subtextColor),
          ),
        ],
      ),
    );
  }
}
