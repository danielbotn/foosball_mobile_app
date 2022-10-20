import 'package:flutter/material.dart';

import '../../state/user_state.dart';
import '../../utils/app_color.dart';
import '../../utils/helpers.dart';
import '../extended_Text.dart';

class JoinOrganisation extends StatefulWidget {
  final UserState userState;
  const JoinOrganisation({Key? key, required this.userState}) : super(key: key);

  @override
  State<JoinOrganisation> createState() => _JoinOrganisationState();
}

class _JoinOrganisationState extends State<JoinOrganisation> {
  // state
  bool qrScanInProgress = false;
  @override
  Widget build(BuildContext context) {
    Helpers helpers = Helpers();
    return Scaffold(
        appBar: AppBar(
            title: ExtendedText(
                text: 'Join Organisation', userState: widget.userState),
            leading: IconButton(
              icon: const Icon(Icons.chevron_left),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            iconTheme: helpers.getIconTheme(widget.userState.darkmode),
            backgroundColor:
                helpers.getBackgroundColor(widget.userState.darkmode)),
        body: Column(
          children: [
            const Spacer(),
            Visibility(visible: qrScanInProgress, child: const Text('gaur')),
            Padding(
                padding: const EdgeInsets.all(4.0),
                child: Container(
                  height: 60,
                  width: double.infinity,
                  color: Colors.blue[800],
                  child: ElevatedButton(
                    onPressed: () => {
                      setState(() {
                        qrScanInProgress = !qrScanInProgress;
                      })
                    },
                    style: ElevatedButton.styleFrom(
                        primary: widget.userState.darkmode
                            ? AppColors.lightThemeShadowColor
                            : AppColors.buttonsLightTheme,
                        minimumSize: const Size(200, 50)),
                    child: const Text('Scan QR Code'),
                  ),
                ))
          ],
        ));
  }
}

// 

 