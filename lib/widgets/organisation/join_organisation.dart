import 'package:dano_foosball/utils/qr_code_scanner.dart';
import 'package:dano_foosball/widgets/UI/Buttons/Button.dart';
import 'package:flutter/material.dart';
import 'package:dano_foosball/widgets/organisation/organisation.dart';
import '../../api/Organisation.dart';
import '../../state/user_state.dart';
import '../../utils/app_color.dart';
import '../../utils/helpers.dart';
import '../extended_Text.dart';
import 'join_organisation_info_card.dart';

class JoinOrganisation extends StatefulWidget {
  final UserState userState;
  const JoinOrganisation({super.key, required this.userState});

  @override
  State<JoinOrganisation> createState() => _JoinOrganisationState();
}

class _JoinOrganisationState extends State<JoinOrganisation> {
  String result = "Hey there !";

  String? _result = "";

  void setResult(String result) async {
    setState(() => _result = result);

    if (result.isNotEmpty &&
        result.contains('organisationCode') &&
        result.contains('organisationId')) {
      bool wasJoiningSuccessful = await joinOrganisation();

      // let user know
      if (wasJoiningSuccessful) {
        await showMyDialog(
            'You have joined a new organisation. Congratulations',
            widget.userState.hardcodedStrings.success);
        if (!mounted) return;
        goToOrganisation(context);
      } else {
        await showMyDialog(widget.userState.hardcodedStrings.obsFailure,
            widget.userState.hardcodedStrings.failure);
      }
    }
  }

  // Dialog for success or error message when
  // user creates a new organisation
  Future<void> showMyDialog(String message, String headline) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(headline),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(message),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(widget.userState.hardcodedStrings.close),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<bool> joinOrganisation() async {
    try {
      bool success = false;
      Organisation org = Organisation();
      var orgData = await org.joinOrganisation(result);

      if (orgData.statusCode == 204) {
        success = true;
      } else {
        success = false;
      }
      return success;
    } on Exception {
      return false;
    } catch (error) {
      return false;
    }
  }

  goToOrganisation(BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => OrganisationScreen(
                  userState: widget.userState,
                )));
  }

  void scanQrWithContext(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => QrCodeScanner(setResult: setResult),
    ));
  }

  // state
  bool qrScanInProgress = false;
  @override
  Widget build(BuildContext context) {
    Helpers helpers = Helpers();
    return Scaffold(
      appBar: AppBar(
        title: ExtendedText(
          text: widget.userState.hardcodedStrings.joinOrganisation,
          userState: widget.userState,
        ),
        leading: IconButton(
          icon: const Icon(Icons.chevron_left),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        iconTheme: helpers.getIconTheme(widget.userState.darkmode),
        backgroundColor: helpers.getBackgroundColor(widget.userState.darkmode),
      ),
      body: Container(
        color: widget.userState.darkmode
            ? AppColors.darkModeLighterBackground
            : AppColors.white,
        child: Column(
          children: [
            JoinOrganisationInfoCard(userState: widget.userState),
            const Spacer(),
            Button(
              userState: widget.userState,
              onClick: () => {
                setState(() {
                  qrScanInProgress = !qrScanInProgress;
                  scanQrWithContext(context);
                })
              },
              text: widget.userState.hardcodedStrings.scanQrCode,
              paddingBottom: 16,
              paddingLeft: 16,
              paddingRight: 16,
              paddingTop: 16,
            ),
          ],
        ),
      ),
    );
  }
}
