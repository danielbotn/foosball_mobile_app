import 'package:flutter/material.dart';
import 'package:foosball_mobile_app/state/user_state.dart';
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
          Text(
            widget.userState.hardcodedStrings.welcomeTextHeadline,
            style: const TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20.0),
          Text(
            widget.userState.hardcodedStrings.welcomeTextBody,
            style: const TextStyle(
              fontSize: 16.0,
            ),
            textAlign: TextAlign.center,
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
