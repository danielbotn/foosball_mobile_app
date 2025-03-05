import 'package:flutter/material.dart';
import 'package:dano_foosball/utils/app_color.dart';
import 'package:dano_foosball/state/user_state.dart';

class Other extends StatelessWidget {
  final UserState userState;
  final int upTo; // Winning score
  final Function(int) onScoreChanged; // Callback to update score
  final bool goalOneConnected;
  final bool goalTwoConnected;
  final bool serverConnected;

  const Other({
    super.key,
    required this.userState,
    required this.upTo,
    required this.onScoreChanged,
    required this.goalOneConnected,
    required this.goalTwoConnected,
    required this.serverConnected,
  });

  BoxDecoration _boxDecoration({Color? borderColor, Color? boxColor}) {
    return BoxDecoration(
      color: boxColor ??
          (userState.darkmode ? AppColors.darkModeBackground : AppColors.white),
      borderRadius: BorderRadius.circular(8),
      border: Border.all(
        color: borderColor ?? Colors.grey.withOpacity(0.5),
        width: 1.0,
      ),
    );
  }

  // Winning Score and Connection Status (Merged UI)
  Widget _buildSettingsBox(Color textColor, Color boxColor, Color borderColor) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: _boxDecoration(boxColor: boxColor, borderColor: borderColor),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Winning Score

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Winning Score',
                style: TextStyle(fontSize: 14, color: textColor),
              ),
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.remove),
                    color: textColor,
                    onPressed: () {
                      if (upTo > 1) onScoreChanged(upTo - 1);
                    },
                  ),
                  Text(
                    '$upTo',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: textColor),
                  ),
                  IconButton(
                    icon: const Icon(Icons.add),
                    color: textColor,
                    onPressed: () {
                      if (upTo < 50) onScoreChanged(upTo + 1);
                    },
                  ),
                ],
              ),
            ],
          ),

          // Connection Status

          const SizedBox(height: 8),
          _buildConnectionItem("Goal One Sensors", goalOneConnected),
          _buildConnectionItem("Goal Two Sensors", goalTwoConnected),
          _buildConnectionItem("Server Connection", serverConnected),
        ],
      ),
    );
  }

  // Connection Indicator Row
  Widget _buildConnectionItem(String label, bool isConnected) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label,
              style: const TextStyle(fontSize: 14, color: Colors.white)),
          Container(
            width: 12,
            height: 12,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isConnected ? Colors.greenAccent : Colors.redAccent,
              boxShadow: [
                BoxShadow(
                  color: isConnected ? Colors.green : Colors.red,
                  blurRadius: 6,
                  spreadRadius: 2,
                ),
              ],
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

    return _buildSettingsBox(textColor, boxColor, borderColor);
  }
}
