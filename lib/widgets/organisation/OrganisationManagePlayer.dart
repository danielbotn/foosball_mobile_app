import 'package:flutter/material.dart';

import '../../api/UserApi.dart';
import '../../models/user/user_response.dart';
import '../../state/user_state.dart';
import '../../utils/app_color.dart';
import '../../utils/helpers.dart';
import '../extended_Text.dart';
import '../loading.dart';

class OrganisationManagePlayer extends StatefulWidget {
  final UserState userState;
  final UserResponse userData;
  const OrganisationManagePlayer(
      {Key? key, required this.userState, required this.userData})
      : super(key: key);

  @override
  State<OrganisationManagePlayer> createState() =>
      _OrganisationManagePlayerState();
}

class _OrganisationManagePlayerState extends State<OrganisationManagePlayer> {
  @override
  Widget build(BuildContext context) {
    Helpers helpers = Helpers();
    return Scaffold(
        appBar: AppBar(
            title: ExtendedText(
                text: widget.userState.hardcodedStrings.managePlayer,
                userState: widget.userState),
            leading: IconButton(
              icon: const Icon(Icons.chevron_left),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            iconTheme: helpers.getIconTheme(widget.userState.darkmode),
            backgroundColor:
                helpers.getBackgroundColor(widget.userState.darkmode)),
        body: Container());
  }
}
