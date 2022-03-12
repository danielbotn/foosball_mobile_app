import 'package:flutter/material.dart';
import 'package:foosball_mobile_app/state/user_state.dart';
import 'package:foosball_mobile_app/utils/app_color.dart';

class Headline extends StatelessWidget {

  final UserState userState;
  final String headline;
  Headline({required this.headline, required this.userState});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      height: 48,
      color: userState.darkmode ? AppColors.darkModeBackground : AppColors.white,
      child: Row(
        children: <Widget>[
          Expanded(
            child: Align(
              alignment: Alignment.centerLeft,
              child: Container(
                margin: const EdgeInsets.only(left: 10),
                child: Text('$headline',  style: TextStyle(fontWeight: FontWeight.bold, color: userState.darkmode ? AppColors.white : AppColors.primaryDark)),
              ),
            ),
          ),
          Expanded(
            child: Align(
              alignment: Alignment.centerRight,
              child: Container(
                margin: const EdgeInsets.only(right: 10),
                child: Icon(Icons.keyboard_arrow_right, color: userState.darkmode ? AppColors.white : AppColors.grey2),
              ),
            ),
          ),
        ],
      ),
    );
  }
}