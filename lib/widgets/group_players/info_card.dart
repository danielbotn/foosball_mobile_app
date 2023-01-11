import 'package:flutter/material.dart';
import 'package:foosball_mobile_app/state/user_state.dart';
import 'package:foosball_mobile_app/utils/app_color.dart';
import 'package:foosball_mobile_app/widgets/extended_Text.dart';

class InfoCard extends StatelessWidget {
  final UserState userState;
  const InfoCard({Key? key, required this.userState}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: userState.darkmode
          ? const Color.fromARGB(255, 80, 80, 80)
          : AppColors.white,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        children: [
          Stack(
            children: [
              Ink.image(
                image: const NetworkImage(
                  'https://images.unsplash.com/photo-1471965187167-4a4c69ae4707?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1781&q=80',
                ),
                height: 240,
                fit: BoxFit.cover,
              ),
              const Positioned(
                bottom: 16,
                right: 16,
                left: 16,
                child: Text(
                  'Create Group user',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(16).copyWith(bottom: 0),
            child: ExtendedText(
              text:
                  'Group players can be used by all players in organisation. Group players can not log in to the system',
              userState: userState,
            ),
          ),
        ],
      ),
    );
  }
}
