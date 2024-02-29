import 'package:flutter/material.dart';
import 'package:foosball_mobile_app/state/user_state.dart';
import 'package:foosball_mobile_app/widgets/extended_Text.dart';
import 'package:foosball_mobile_app/widgets/organisation/new_organisation.dart';

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
    return Container(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ExtendedText(
            text: widget.userState.hardcodedStrings.welcomeTextHeadline,
            userState: widget.userState,
            fontSize: 24,
          ),
          const SizedBox(height: 20.0),
          ExtendedText(
            text: widget.userState.hardcodedStrings.welcomeTextBody,
            userState: widget.userState,
            fontSize: 16,
          ),
          const SizedBox(height: 20.0),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => NewOrganisation(
                            userState: widget.userState,
                            notifyOrganisationButtons: notifyOrganisation,
                          )));
            },
            child: Text(widget.userState.hardcodedStrings.welcomeTextButton),
          ),
        ],
      ),
    );
  }
}
