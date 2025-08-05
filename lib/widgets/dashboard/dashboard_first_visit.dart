import 'package:dano_foosball/utils/app_color.dart';
import 'package:dano_foosball/widgets/UI/Buttons/Button.dart';
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

  void _onButtonClick() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => NewOrganisation(
          userState: widget.userState,
          notifyOrganisationButtons: notifyOrganisation,
        ),
      ),
    );
  }

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
          // Padding(
          //   padding: const EdgeInsets.only(bottom: 30.0),
          //   child: Image.asset('assets/images/dano-scaled.png', height: 100),
          // ),
          // Welcome text headline
          // ExtendedText(
          //   text: widget.userState.hardcodedStrings.welcomeTextHeadline,
          //   userState: widget.userState,
          //   fontSize: 24,
          // ),
          const SizedBox(height: 20.0),
          // Welcome text body
          FeatureIntroSlider(userState: widget.userState),
          // Padding(
          //   padding: const EdgeInsets.only(left: 10, right: 10),
          //   child: ExtendedText(
          //     text: widget.userState.hardcodedStrings.welcomeTextBody,
          //     userState: widget.userState,
          //     fontSize: 16,
          //   ),
          // ),

          // Button
          Button(
            userState: widget.userState,
            onClick: _onButtonClick,
            text: widget.userState.hardcodedStrings.welcomeTextButton,
            paddingBottom: 10,
            paddingLeft: 10,
            paddingRight: 10,
            paddingTop: 10,
          ),
        ],
      ),
    );
  }
}
