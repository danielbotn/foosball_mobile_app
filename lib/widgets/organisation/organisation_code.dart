import 'package:flutter/material.dart';
import 'package:dano_foosball/main.dart';
import 'package:dano_foosball/models/organisation/organisation_response.dart';
import 'package:dano_foosball/widgets/loading.dart';
import 'package:qr_flutter/qr_flutter.dart';
import '../../api/Organisation.dart';
import '../../state/user_state.dart';
import '../../utils/app_color.dart';
import '../../utils/helpers.dart';
import '../extended_Text.dart';

class OrganisationCode extends StatefulWidget {
  final UserState userState;
  const OrganisationCode({Key? key, required this.userState}) : super(key: key);

  @override
  State<OrganisationCode> createState() => _OrganisationCodeState();
}

class _OrganisationCodeState extends State<OrganisationCode> {
  // state
  late Future<OrganisationResponse?> organisationFuture;
  late OrganisationResponse? organisationData;

  @override
  void initState() {
    super.initState();
    organisationFuture = getOrganisation();
  }

  Future<OrganisationResponse?> getOrganisation() async {
    Organisation org = Organisation();
    var orgData = await org
        .getOrganisationById(userState.userInfoGlobal.currentOrganisationId);

    organisationData = orgData;
    return orgData;
  }

  @override
  Widget build(BuildContext context) {
    Helpers helpers = Helpers();
    return Scaffold(
        appBar: AppBar(
            title: ExtendedText(
                text: widget.userState.hardcodedStrings.organisationCode,
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
        body: FutureBuilder(
          future: organisationFuture,
          builder: (context, AsyncSnapshot<OrganisationResponse?> snapshot) {
            if (snapshot.hasData) {
              return Container(
                color: widget.userState.darkmode
                    ? AppColors.darkModeBackground
                    : AppColors.white,
                child: Column(
                  children: <Widget>[
                    QrImageView(
                      backgroundColor: AppColors.white,
                      data:
                          'organisationCode: ${organisationData!.organisationCode}, organisationId: ${organisationData!.id}',
                      version: QrVersions.auto,
                      size: 320,
                      gapless: false,
                      // embeddedImage:
                      //     const AssetImage('assets/images/dano-scaled.png'),
                      // embeddedImageStyle: QrEmbeddedImageStyle(
                      //   size: const Size(80, 80),
                      // ),
                      // size: 200.0,
                    ),
                    Padding(
                        padding:
                            const EdgeInsets.only(left: 25, right: 25, top: 10),
                        child: Center(
                            child: ExtendedText(
                          text: widget
                              .userState.hardcodedStrings.joinOrganisationInfo,
                          userState: userState,
                          fontSize: 19,
                        ))),
                    Padding(
                        padding:
                            const EdgeInsets.only(left: 25, right: 25, top: 10),
                        child: Center(
                            child: ExtendedText(
                          text: widget
                              .userState.hardcodedStrings.joinOrganisationInfo2,
                          userState: userState,
                          fontSize: 19,
                        )))
                  ],
                ),
              );
            } else {
              return Loading(userState: userState);
            }
          },
        ));
  }
}
