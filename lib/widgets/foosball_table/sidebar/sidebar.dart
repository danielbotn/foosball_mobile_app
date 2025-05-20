import 'package:dano_foosball/state/user_state.dart';
import 'package:dano_foosball/utils/app_color.dart';
import 'package:dano_foosball/widgets/Login.dart';
import 'package:flutter/material.dart';

class Sidebar extends StatelessWidget {
  final UserState userState;
  final void Function(bool) setDarkMode;

  const Sidebar(
      {super.key, required this.userState, required this.setDarkMode});

  goToLoginScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Login(
          userState: userState,
        ),
      ),
    );
  }

  toggleDarkMode(BuildContext context) {
    bool isDarkMode = userState.darkmode;
    userState.setDarkmode(!isDarkMode);
    setDarkMode(!isDarkMode);
  }

  Widget _buildSidebar(BuildContext context) {
    Color iconColor = userState.darkmode ? AppColors.white : Colors.grey[700]!;
    Color backgroundColor =
        userState.darkmode ? AppColors.darkModeBackground : AppColors.white;

    return Container(
      width: 100,
      color: backgroundColor.withAlpha((0.9 * 255).toInt()),
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Image.asset(
            'assets/images/dano-scaled.png',
            width: 80,
            height: 80,
          ),
          const SizedBox(height: 20),
          IconButton(
            icon: Icon(Icons.login, color: iconColor),
            onPressed: () {
              goToLoginScreen(context);
            },
          ),
          const SizedBox(height: 8),
          IconButton(
            icon: Icon(userState.darkmode ? Icons.dark_mode : Icons.light_mode,
                color: iconColor),
            onPressed: () {
              toggleDarkMode(context);
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildSidebar(context);
  }
}
