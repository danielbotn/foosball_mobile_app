import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:majascan/majascan.dart';
import '../../api/Organisation.dart';
import '../../state/user_state.dart';
import '../../utils/app_color.dart';
import '../../utils/helpers.dart';
import '../extended_Text.dart';
import 'package:http/http.dart' as http;

class JoinOrganisation extends StatefulWidget {
  final UserState userState;
  const JoinOrganisation({Key? key, required this.userState}) : super(key: key);

  @override
  State<JoinOrganisation> createState() => _JoinOrganisationState();
}

class _JoinOrganisationState extends State<JoinOrganisation> {
  String result = "Hey there !";

  Future<bool> joinOrganisation() async {
    bool success = false;
    String token = widget.userState.token;
    Organisation org = Organisation(token: token);
    var orgData = await org.joinOrganisation(result);

    if (orgData.statusCode == 204) {
      success = true;
    } else {
      success = false;
    }
    return success;
  }

  Future _scanQR() async {
    try {
      String? qrResult = await MajaScan.startScan(
          title: "QRcode scanner",
          titleColor: Colors.amberAccent[700],
          qRCornerColor: Colors.orange,
          qRScannerColor: Colors.orange);
      setState(() {
        result = qrResult ?? 'null string';
      });
    } on PlatformException catch (ex) {
      if (ex.code == MajaScan.CameraAccessDenied) {
        setState(() {
          result = "Camera permission was denied";
        });
      } else {
        setState(() {
          result = "Unknown Error $ex";
        });
      }
    } on FormatException {
      setState(() {
        result = "You pressed the back button before scanning anything";
      });

      if (result.isNotEmpty &&
          result.contains('organisationCode') &&
          result.contains('organisationId')) {
        bool wasJoiningSuccessful = await joinOrganisation();

        // let user know
      }
    } catch (ex) {
      setState(() {
        result = "Unknown Error $ex";
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
            Text(result),
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
                        _scanQR();
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

 