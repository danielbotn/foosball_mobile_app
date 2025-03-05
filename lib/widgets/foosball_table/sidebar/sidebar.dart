import 'package:dano_foosball/state/user_state.dart';
import 'package:dano_foosball/utils/app_color.dart';
import 'package:flutter/material.dart';

class Sidebar extends StatelessWidget {
  final UserState userState;
  const Sidebar({super.key, required this.userState});

  Widget _buildSidebar() {
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
            icon: const Icon(Icons.calendar_today, color: Colors.white),
            onPressed: () {},
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
    return _buildSidebar();
  }
}
