import 'package:dano_foosball/state/user_state.dart';
import 'package:dano_foosball/utils/app_color.dart';
import 'package:flutter/material.dart';

class Scoreboard extends StatelessWidget {
  final UserState userState;
  final Duration gameDuration; // Duration of the game
  final int teamOneScore; // Score for Team One
  final int teamTwoScore; // Score for Team Two
  final Function(String) onPlayerImageClick; // Callback for updating scores
  final bool gameStarted; // Flag to check if the game is started
  final bool gamePaused; // Flag to check if the game is paused
  final int upTo;
  final Function() onGameOver; // Callback when game is over

  const Scoreboard(
      {super.key,
      required this.userState,
      required this.gameDuration,
      required this.teamOneScore, // Pass team one score
      required this.teamTwoScore, // Pass team two score
      required this.onPlayerImageClick, // Pass the function to handle click
      required this.gameStarted, // Receive the gameStarted state
      required this.gamePaused, // Receive the gamePaused state
      required this.upTo,
      required this.onGameOver});

  BoxDecoration _boxDecoration({
    Color? borderColor,
    Color? boxColor,
    double borderWidth = 1.0,
    double shadowOpacity = 0.1,
    double shadowSpread = 2,
    double shadowBlur = 5,
  }) {
    return BoxDecoration(
      color: boxColor ??
          (userState.darkmode ? AppColors.darkModeBackground : AppColors.white),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(
        color: borderColor ?? Colors.transparent,
        width: borderWidth,
      ),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(shadowOpacity),
          blurRadius: shadowBlur,
          spreadRadius: shadowSpread,
        ),
      ],
    );
  }

  String _formatDuration(Duration duration) {
    // Format the duration as HH:MM:SS
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    String twoDigitHours = twoDigits(duration.inHours);
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "$twoDigitHours:$twoDigitMinutes:$twoDigitSeconds";
  }

  Widget _buildScoreboard(Color textColor, Color boxColor, Color borderColor) {
    bool isGameOver = teamOneScore >= upTo || teamTwoScore >= upTo;

    // If game is over, trigger the callback
    if (isGameOver) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        onGameOver();
      });
    }

    return Container(
      height: 180,
      padding: const EdgeInsets.all(20),
      decoration: _boxDecoration(
        boxColor: boxColor,
        borderColor: borderColor,
        borderWidth: 1.0,
        shadowOpacity: 0.15,
        shadowSpread: 3,
        shadowBlur: 8,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          // Left Team
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  if (gameStarted && !gamePaused && !isGameOver) {
                    onPlayerImageClick('teamOne');
                  }
                },
                child: Image.asset(
                  'assets/images/player_one_transparent.png',
                  width: 90,
                  height: 90,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                "Grey Team",
                style: TextStyle(
                    fontSize: 18,
                    color: textColor,
                    fontWeight: FontWeight.w500),
              ),
            ],
          ),

          // Center Score
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "$teamOneScore - $teamTwoScore",
                style: TextStyle(
                  fontSize: 66,
                  fontWeight: FontWeight.bold,
                  color: textColor,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                isGameOver ? "Full Time" : _formatDuration(gameDuration),
                style: TextStyle(
                  fontSize: 20,
                  color: textColor.withOpacity(0.8),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),

          // Right Team
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  if (gameStarted && !gamePaused && !isGameOver) {
                    onPlayerImageClick('teamTwo');
                  }
                },
                child: Image.asset(
                  'assets/images/player_two_transparent.png',
                  width: 90,
                  height: 90,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                "Blue Team",
                style: TextStyle(
                    fontSize: 18,
                    color: textColor,
                    fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Color textColor = userState.darkmode ? Colors.white : Colors.black;
    Color boxColor = userState.darkmode
        ? AppColors.darkModeBackground.withOpacity(0.8)
        : AppColors.white;
    Color accentBorderColor = userState.darkmode
        ? Colors.white.withOpacity(0.3)
        : Colors.grey.withOpacity(0.5);
    return _buildScoreboard(textColor, boxColor, accentBorderColor);
  }
}
