import 'package:flutter/material.dart';

import '../../state/user_state.dart';

class OrganisationCard extends StatelessWidget {
  final UserState userState;
  const OrganisationCard({Key? key, required this.userState}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      // elevation: 5,
      child: ListTile(
        leading: const Icon(Icons.home_work_rounded, color: Colors.grey),
        title: Text(userState.hardcodedStrings.currentOrganisation),
        subtitle: Text(userState.userInfoGlobal.currentOrganisationName),
      ),
    );
  }
}
