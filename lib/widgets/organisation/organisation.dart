import 'package:flutter/material.dart';

import '../../state/user_state.dart';
import '../../utils/helpers.dart';
import '../extended_Text.dart';

class OrgnisationScreen extends StatelessWidget {
  final UserState userState;
  const OrgnisationScreen({Key? key, required this.userState})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Helpers helpers = Helpers();
    return Scaffold(
        appBar: AppBar(
            title: ExtendedText(
                text: userState.hardcodedStrings.organisation,
                userState: userState),
            leading: IconButton(
              icon: const Icon(Icons.chevron_left),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            iconTheme: helpers.getIconTheme(userState.darkmode),
            backgroundColor: helpers.getBackgroundColor(userState.darkmode)),
        body: Column(
          children: [
            Card(
              child: ListTile(
                  leading: const Icon(Icons.house_siding_rounded),
                  title: Text(userState.hardcodedStrings.currentOrganisation),
                  subtitle:
                      Text(userState.userInfoGlobal.currentOrganisationName)),
            ),
            const Divider()
          ],
        ));
  }
}
