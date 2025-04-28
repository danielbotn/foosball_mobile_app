import 'package:dano_foosball/state/user_state.dart';
import 'package:dano_foosball/utils/app_color.dart';
import 'package:flutter/material.dart';

class TimerControls extends StatelessWidget {
  final UserState userState;
  final bool gameStarted;
  final bool gamePaused;
  final Duration duration;
  final VoidCallback onStartGame;
  final VoidCallback onPause;
  final VoidCallback onReset;

  const TimerControls({
    super.key,
    required this.userState,
    required this.gameStarted,
    required this.gamePaused,
    required this.duration,
    required this.onStartGame,
    required this.onPause,
    required this.onReset,
  });

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

  Widget _buildTimerButton(String text, {required VoidCallback onPressed}) {
    return Expanded(
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.grey.shade600,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
          ),
        ),
      ),
    );
  }

  String _formatDuration(Duration duration) {
    String hours = duration.inHours.toString().padLeft(2, '0');
    String minutes =
        duration.inMinutes.remainder(60).toString().padLeft(2, '0');
    String seconds =
        duration.inSeconds.remainder(60).toString().padLeft(2, '0');
    return "$hours:$minutes:$seconds";
  }

  Widget _buildTimerControls(
      Color textColor, Color boxColor, Color borderColor) {
    return Container(
      height: 180,
      decoration: _boxDecoration(boxColor: boxColor, borderColor: borderColor),
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Timer Display
          Text(
            _formatDuration(duration),
            style: TextStyle(
              fontSize: 48,
              fontWeight: FontWeight.bold,
              color: textColor,
            ),
          ),
          const SizedBox(height: 24),

          // Timer Buttons
          if (gameStarted)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildTimerButton("Reset", onPressed: onReset),
                const SizedBox(width: 16),
                _buildTimerButton(gamePaused ? "Resume" : "Pause",
                    onPressed: onPause),
              ],
            )
          else
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: onStartGame,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green.shade600,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  "Start Game",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ),
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
    Color borderColor = userState.darkmode
        ? Colors.white.withOpacity(0.2)
        : Colors.grey.withOpacity(0.3);
    return _buildTimerControls(textColor, boxColor, borderColor);
  }
}
