import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:foosball_mobile_app/widgets/organisation/organisation.dart';
import 'package:majascan/majascan.dart';
import '../../api/Organisation.dart';
import '../../state/user_state.dart';
import '../../utils/app_color.dart';
import '../../utils/helpers.dart';
import '../extended_Text.dart';
import 'join_organisation_info_card.dart';

class JoinOrganisation extends StatefulWidget {
  final UserState userState;
  const JoinOrganisation({Key? key, required this.userState}) : super(key: key);

  @override
  State<JoinOrganisation> createState() => _JoinOrganisationState();
}

class _JoinOrganisationState extends State<JoinOrganisation> {
  String result = "Hey there !";

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

  void scanQrWithContext(BuildContext context) async {
    await scanQR(context);
  }

  Future scanQR(BuildContext context) async {
    try {
      String? qrResult = await MajaScan.startScan(
          title: "QRcode scanner",
          titleColor: Colors.amberAccent[700],
          qRCornerColor: Colors.orange,
          qRScannerColor: Colors.orange);
      setState(() {
        result = qrResult ?? 'null string';
      });

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
    } on PlatformException catch (ex) {
      if (ex.code == MajaScan.CameraAccessDenied) {
        setState(() {
          result = widget.userState.hardcodedStrings.cameraPermissionWasDenied;
        });
      } else {
        setState(() {
          result = "${widget.userState.hardcodedStrings.unknownError}$ex";
        });
      }
    } on FormatException {
      setState(() {
        result = widget.userState.hardcodedStrings.youPressedTheBackButton;
      });
    } catch (ex) {
      setState(() {
        result = "${widget.userState.hardcodedStrings.unknownError}$ex";
      });
    }
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
        body: Column(
          children: [
            JoinOrganisationInfoCard(userState: widget.userState),
            const Spacer(),
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
                        scanQrWithContext(context);
                      })
                    },
                    style: ElevatedButton.styleFrom(
                        primary: widget.userState.darkmode
                            ? AppColors.lightThemeShadowColor
                            : AppColors.buttonsLightTheme,
                        minimumSize: const Size(200, 50)),
                    child: Text(widget.userState.hardcodedStrings.scanQrCode),
                  ),
                ))
          ],
        ));
  }
}
