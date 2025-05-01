import 'package:dano_foosball/state/user_state.dart';
import 'package:dano_foosball/utils/app_color.dart';
import 'package:dano_foosball/widgets/Login.dart';
import 'package:flutter/material.dart';

class Sidebar extends StatelessWidget {
  final UserState userState;
  const Sidebar({super.key, required this.userState});

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

  Widget _buildSidebar(BuildContext context) {
    return Container(
      width: 100,
      color: AppColors.darkModeBackground.withOpacity(0.9),
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
            icon: const Icon(Icons.login, color: Colors.white),
            onPressed: () {
              goToLoginScreen(context);
            },
          ),
          const SizedBox(height: 8),
          IconButton(
            icon: const Icon(Icons.settings, color: Colors.white),
            onPressed: () {},
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
