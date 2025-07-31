import 'package:dano_foosball/utils/app_color.dart';
import 'package:dano_foosball/widgets/dashboard/dashboard_feature_intro_slider.dart';
import 'package:flutter/material.dart';
import 'package:dano_foosball/state/user_state.dart';
import 'package:dano_foosball/widgets/extended_Text.dart';
import 'package:dano_foosball/widgets/organisation/new_organisation.dart';

class DashBoardFirstVisit extends StatefulWidget {
  final UserState userState;
  const DashBoardFirstVisit({Key? key, required this.userState})
    : super(key: key);

  @override
  State<DashBoardFirstVisit> createState() => _DashBoardFirstVisitState();
}

class _DashBoardFirstVisitState extends State<DashBoardFirstVisit> {
  void notifyOrganisation() {}

  @override
  Widget build(BuildContext context) {
    bool darkMode = widget.userState.darkmode;

    return Container(
      color: darkMode
          ? AppColors.darkModeBackground
          : Colors.white, // <--- Added
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Dano logo
          Padding(
            padding: const EdgeInsets.only(bottom: 30.0),
            child: Image.asset('assets/images/dano-scaled.png', height: 100),
          ),
          // Welcome text headline
          ExtendedText(
            text: widget.userState.hardcodedStrings.welcomeTextHeadline,
            userState: widget.userState,
            fontSize: 24,
          ),
          const SizedBox(height: 20.0),
          // Welcome text body
          ExtendedText(
            text: widget.userState.hardcodedStrings.welcomeTextBody,
            userState: widget.userState,
            fontSize: 16,
          ),

          FeatureIntroSlider(darkMode: true),

          const SizedBox(height: 20.0),

          // Button
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => NewOrganisation(
                    userState: widget.userState,
                    notifyOrganisationButtons: notifyOrganisation,
                  ),
                ),
              );
            },
            child: Text(widget.userState.hardcodedStrings.welcomeTextButton),
          ),
        ],
      ),
    );
  }
}
