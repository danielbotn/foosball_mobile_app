import 'package:flutter/material.dart';
import 'package:foosball_mobile_app/state/user_state.dart';
import 'package:foosball_mobile_app/utils/app_color.dart';

class NoUsersFoundMessage extends StatelessWidget {
  final UserState userState;

  const NoUsersFoundMessage({Key? key, required this.userState})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.person_off_sharp,
            color: userState.darkmode ? AppColors.white : null,
            size: 48,
          ),
          const SizedBox(height: 16),
          Text(
            userState.hardcodedStrings.noUsersExists,
            style: TextStyle(
              fontSize: 16,
              color: userState.darkmode ? AppColors.white : null,
            ),
          ),
        ],
      ),
    );
  }
}
